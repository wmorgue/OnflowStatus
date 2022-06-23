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
	var developers: [Services] = []

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

	func debugDump<T>(_ value: T) -> T {
		#if targetEnvironment(simulator)
			dump(value, indent: 2)
		#endif
	}

	func showSheet(for service: Services) {
		guard service.events.isEmpty else {
			showingSheet.toggle()
			return
		}
	}

	/*
	 1. Responce status = 200
	 2. The request timed out
	 3. Split method's below to ServiceAPI
	 */

	func getSupportServices(for language: String = "en_US") async {
		let statusCode = try? await client
			.send(.get("/system_status_\(language).js"))
			.statusCode

		guard statusCode == 200 else {
			// showing view with retry button insdead a alert with try again button
			Logger.serviceModel.info("The server responded with an error. Status code: \(statusCode.debugDescription)")
			return
		}

		do {
			let status: SupportStatus = try await client.send(.get("/system_status_\(language).js")).value
			//						debugDump(status)
			services = status.services
		} catch {
			Logger.serviceModel.error("\(error)")
		}
	}

	func getDeveloperServices(for language: String = "en_US") async {
		do {
			// Return a JSON-P with callback so we need to remove a garbage
			var callbackResult: String = try await client.send(.get("/developer/system_status_\(language).js")).value
			callbackResult.removeFirst(13)
			callbackResult.removeLast(3)

			let callbackResultData = callbackResult.data(using: .utf8)!

			let isValidObject: Bool = JSONSerialization.isValidJSONObject(callbackResult)

			guard !isValidObject else {
				Logger.serviceModel.error("Invalid JSON: \(#function)")
				return
			}

			let status: SupportStatus = try! JSONDecoder().decode(SupportStatus.self, from: callbackResultData)

			//						debugDump(status)
			developers = status.services
		} catch {
			Logger.serviceModel.error("\(error)")
		}
	}

	func relativeStartDate(from startDate: String) -> String {
		let strategy = Date.ParseStrategy(format: "\(month: .twoDigits)/\(day: .twoDigits)/\(year: .defaultDigits) \(hour: .twoDigits(clock: .twelveHour, hourCycle: .zeroBased)):\(minute: .twoDigits) PDT", locale: Locale(identifier: "en_US"), timeZone: .current)
		guard let date = try? Date(startDate, strategy: strategy) else { return Date.now.formatted() }

		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full

		return formatter.localizedString(for: date, relativeTo: .now)
	}
}
