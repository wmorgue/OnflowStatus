//
//  ServiceViewModel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/17/22.
//

import Get
import OSLog
import SwiftUI

enum EventStatusMessage {
	case support
	case developer

	var text: String {
		switch self {
		case .support: return "resolved"
		case .developer: return "completed"
		}
	}
}

enum AppIcon {
	case dark
	case light

	var iconName: String? {
		switch self {
		case .dark: return nil
		case .light: return "LightIcon"
		}
	}
}

final class ServiceViewModel: ObservableObject {
	let networking = StatusResource()

	@Published
	var services: [Services] = []

	@Published
	var developers: [Services] = []

	@Published
	var showingAlert: Bool = false

	@Published
	var alertErrorMessage: String?

	@Published
	var showingSheet: Bool = false

	@Published
	var showingDevSheet: Bool = false

	@Published
	var supportSearchText: String = ""

	@Published
	var developerSearchText: String = ""

	@Published
	var isFilteredSupport: Bool = false

	@Published
	var isFilteredDeveloper: Bool = false

	@AppStorage("isCompactView")
	var isCompactView: Bool = false
}

private extension Logger {
	static let serviceModel = Logger(
		subsystem: .bundleIdentifier,
		category: String(describing: ServiceViewModel.self)
	)
}

extension ServiceViewModel {
	static let preview = ServiceViewModel()

	func setCircleColor(_ service: Services, message: EventStatusMessage) -> Color {
		service
			.events
			.map(\.eventStatus.localizedLowercase)
			.contains(message.text.lowercased()) || service.events.isEmpty ? .green : .orange
	}

//	func tryCompactView(for service: Services, text: String) -> Bool {
//		service.events.isEmpty || service.events.map(\.eventStatus).contains(text) ? true : false
//	}

	@MainActor
	func fetchSupport() async {
		do {
			services = try await networking.fetchSupportServices()
		} catch {
			showingAlert = true
			alertErrorMessage = error.localizedDescription
			Logger.serviceModel.error("\(error)")
		}
	}

	@MainActor
	func fetchDeveloper() async {
		do {
			developers = try await networking.fetchDeveloperServices()
		} catch {
			showingAlert = true
			alertErrorMessage = error.localizedDescription
			Logger.serviceModel.error("\(error)")
		}
	}

	func relativeStartDate(from startDate: String) -> String {
		let strategy = Date.ParseStrategy(format: "\(month: .twoDigits)/\(day: .twoDigits)/\(year: .defaultDigits) \(hour: .twoDigits(clock: .twelveHour, hourCycle: .zeroBased)):\(minute: .twoDigits) PDT", locale: Locale(identifier: networking.locale), timeZone: .current)
		guard let date = try? Date(startDate, strategy: strategy) else { return Date.now.formatted() }

		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full

		return formatter.localizedString(for: date, relativeTo: .now)
	}

	var alertMessageReason: Text {
		Text("Can't load a services.\n") + Text(alertErrorMessage ?? "")
	}

	// MARK: - Support
	func showSheet(for service: Services) {
		guard service.events.isEmpty else {
			showingSheet.toggle()
			return
		}
	}

	var supportEventsIsEmpty: Bool { services.flatMap(\.events).isEmpty }

	var filteredSupportBySearchText: [Services] {
		supportSearchText.isEmpty ? services : services.filter { $0.matches(searchText: supportSearchText) }
	}

	var supportList: [Services] {
		isFilteredSupport ? filteredSupportBySearchText.filter(\.events.isNotEmpty) : filteredSupportBySearchText
	}

	// MARK: - Developer
	var developerEventsIsEmpty: Bool { developers.flatMap(\.events).isEmpty }

	var filteredDeveloperBySearchText: [Services] {
		developerSearchText.isEmpty ? developers : developers.filter { $0.matches(searchText: developerSearchText) }
	}

	var developerList: [Services] {
		isFilteredDeveloper ? filteredDeveloperBySearchText.filter(\.events.isNotEmpty) : filteredDeveloperBySearchText
	}

	@MainActor
	func chooseAppIcon(for icon: AppIcon) async {
		do {
			try await UIApplication.shared.setAlternateIconName(icon.iconName)
		} catch {
			Logger.serviceModel.error("\(error)")
		}
	}
}
