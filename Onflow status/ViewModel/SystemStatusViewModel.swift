//
//  SystemStatusViewModel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 8/3/22.
//

import OnflowNetwork
import OSLog
import SwiftUI

final class SystemStatusViewModel: ObservableObject {
	let onflowService: OnflowServiceProtocol

	/// Array with services
	@Published
	var systemData: [Services] = []

	@Published
	var showingAlert: Bool = false

	@Published
	var alertErrorMessage: String?

	@Published
	var showingSheet: Bool = false

	@Published
	var searchText: String = ""

	@Published
	var isFiltered: Bool = false

	@Published
	var currentSheetService: Services?

	@AppStorage("isCompactView")
	var isCompactView: Bool = false

	init(onflowService: OnflowServiceProtocol) {
		self.onflowService = onflowService
	}
}

extension SystemStatusViewModel {
	var alertMessageReason: Text {
		Text("alert-topMessage") + Text("\n") + Text(alertErrorMessage ?? "")
	}

	func showSheet(for service: Services) {
		guard service.events.isEmpty else {
			currentSheetService = service
			return
		}
	}

	var badgeCountToday: Int? {

		systemData
			.flatMap(\.events)
			.map { Date(timeIntervalSince1970: $0.epochStartDate / 1000) }
			.filter { Calendar.current.isDateInToday($0) }
			.count
	}

	var dismissFilter: Void { isFiltered = false }

	var supportEventsIsEmpty: Bool { systemData.flatMap(\.events).isEmpty }

	var filteredSupportBySearchText: [Services] {
		searchText.isEmpty ? systemData : systemData.filter { $0.matches(searchText: searchText) }
	}

	var supportList: [Services] {
		isFiltered ? filteredSupportBySearchText.filter(\.events.isNotEmpty) : filteredSupportBySearchText
	}

	func updateLocale(for locale: String) {
		onflowService.localeLayer.locale = locale
		#if targetEnvironment(simulator)
			Logger.systemStatus.debug("🟢 Update current locale.")
		#endif
	}

	@MainActor
	func chooseAppIcon(for icon: AppIcon) async {
		do {
			try await UIApplication.shared.setAlternateIconName(icon.iconName)
		} catch {
			Logger.systemStatus.error("🚨 \(#function): \(error)")
		}
	}

	@MainActor
	func fetchServices() async {
		do {
			systemData = try await onflowService.fetchServices()
		} catch {
			showingAlert = true
			alertErrorMessage = error.localizedDescription
			Logger.systemStatus.error("🚨 \(error)")
		}
	}
}
