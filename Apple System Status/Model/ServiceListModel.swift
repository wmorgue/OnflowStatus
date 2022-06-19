//
//  ServiceListModel.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/17/22.
//

import Foundation
import Get
import OSLog

@MainActor
final class ServiceListModel: ObservableObject {
	@Published
	var services: [Services] = []

	@Published
	var showingSheet: Bool = false

	private let client = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus/data"))
}

private extension Logger {
	static let serviceModel = Logger(
		subsystem: Bundle.main.bundleIdentifier!,
		category: String(describing: ServiceListModel.self)
	)
}

extension ServiceListModel {
	static let preview = ServiceListModel()

	func showSheet(for service: Services) {
		guard service.events.isEmpty else {
			showingSheet.toggle()
			return
		}
	}

	func getServices(for language: String = "en_US") async {
		do {
			let status: SupportStatus = try await client.send(.get("/system_status_\(language).js")).value
			#if targetEnvironment(simulator)
				//	dump(status)
			#endif
			services = status.services
		} catch {
			Logger.serviceModel.error("\(error)")
		}
	}
}
