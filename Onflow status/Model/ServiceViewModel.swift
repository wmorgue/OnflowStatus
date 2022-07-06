//
//  ServiceViewModel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/17/22.
//

import Foundation
import Get
import OSLog
import SwiftUI

@MainActor
final class ServiceViewModel: ObservableObject {
	let networking = StatusResource()

	@Published
	var services: [Services] = []

	@Published
	var developers: [Services] = []

	@Published
	var showingAlert: Bool = false

	@Published
	var showingSheet: Bool = false

	@Published
	var showingDevSheet: Bool = false

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

	func showSheet(for service: Services) {
		guard service.events.isEmpty else {
			showingSheet.toggle()
			return
		}
	}

	func setCircleColor(_ service: Services, text: String) -> Color {
		service.events.map(\.eventStatus).contains(text) || service.events.isEmpty ? .green : .orange
	}

//	func showCompactView(for service: Services) {
//		if service.events.isEmpty {
//			isCompactView = true
//		} else {
//			isCompactView = false
//		}
//	}

	func fetchSupport() async {
		do {
			services = try await networking.fetchSupportServices()
		} catch {
			showingAlert = true
			Logger.serviceModel.error("\(error)")
		}
	}

	func fetchDeveloper() async {
		do {
			developers = try await networking.fetchDeveloperServices()
		} catch {
			showingAlert = true
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
}
