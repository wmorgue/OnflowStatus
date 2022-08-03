//
//  ServiceViewModel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/17/22.
//

import Foundation

enum EventStatusMessage {
	case support
	case developer

	var text: String {
		switch self {
		case .support: return "resolved"
		case .developer: return "resolved" // before: completed
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

//
// final class ServiceViewModel: ObservableObject {
//	var networking = NetworkLayer()
//
//	@Published
//	var services: [Services] = []
//
//	@Published
//	var developers: [Services] = []
//
//	@Published
//	var showingAlert: Bool = false
//
//	@Published
//	var alertErrorMessage: String?
//
//	@Published
//	var showingSheet: Bool = false
//
//	@Published
//	var showingDevSheet: Bool = false
//
//	@Published
//	var supportSearchText: String = ""
//
//	@Published
//	var developerSearchText: String = ""
//
//	@Published
//	var isFilteredSupport: Bool = false
//
//	@Published
//	var isFilteredDeveloper: Bool = false
//
//	@Published
//	var currentSheetService: Services?
//
//	@AppStorage("isCompactView")
//	var isCompactView: Bool = false
// }
//
// extension ServiceViewModel {
//	static let preview = ServiceViewModel()
//
////	func tryCompactView(for service: Services, text: String) -> Bool {
////		service.events.isEmpty || service.events.map(\.eventStatus).contains(text) ? true : false
////	}
//
//	@MainActor
//	func fetchSupport() async {
//		do {
//			services = try await networking.fetchSupportServices()
//		} catch {
//			showingAlert = true
//			alertErrorMessage = error.localizedDescription
//			Logger.serviceModel.error("\(error)")
//		}
//	}
//
//	@MainActor
//	func fetchDeveloper() async {
//		do {
//			developers = try await networking.fetchDeveloperServices()
//		} catch {
//			showingAlert = true
//			alertErrorMessage = error.localizedDescription
//			Logger.serviceModel.error("\(error)")
//		}
//	}
//
//	var alertMessageReason: Text {
//		Text("alert-topMessage") + Text("\n") + Text(alertErrorMessage ?? "")
//	}
//
//	// MARK: - Support
//	func showSheet(for service: Services) {
//		guard service.events.isEmpty else {
//			currentSheetService = service
//			return
//		}
//	}
//
//	func updateLocale(for locale: String) {
//		networking.supportLocale = locale
//		#if targetEnvironment(simulator)
//			Logger.serviceModel.debug("🟢 Update current locale.")
//		#endif
//	}
//
//	var dismissFilter: Void {
//		isFilteredSupport = false
//	}
//
//	var supportEventsIsEmpty: Bool { services.flatMap(\.events).isEmpty }
//
//	var filteredSupportBySearchText: [Services] {
//		supportSearchText.isEmpty ? services : services.filter { $0.matches(searchText: supportSearchText) }
//	}
//
//	var supportList: [Services] {
//		isFilteredSupport ? filteredSupportBySearchText.filter(\.events.isNotEmpty) : filteredSupportBySearchText
//	}
//
//	// MARK: - Developer
//	var developerEventsIsEmpty: Bool { developers.flatMap(\.events).isEmpty }
//
//	var filteredDeveloperBySearchText: [Services] {
//		developerSearchText.isEmpty ? developers : developers.filter { $0.matches(searchText: developerSearchText) }
//	}
//
//	var developerList: [Services] {
//		isFilteredDeveloper ? filteredDeveloperBySearchText.filter(\.events.isNotEmpty) : filteredDeveloperBySearchText
//	}
//
//	@MainActor
//	func chooseAppIcon(for icon: AppIcon) async {
//		do {
//			try await UIApplication.shared.setAlternateIconName(icon.iconName)
//		} catch {
//			Logger.serviceModel.error("\(error)")
//		}
//	}
// }
