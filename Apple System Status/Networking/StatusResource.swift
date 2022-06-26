//
//  StatusResource.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/26/22.
//

import Foundation
import Get
import OSLog

private extension Logger {
	static var statusResource: Logger {
		Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: StatusResource.self))
	}
}

private enum RequestConstant {
	static let timeoutInterval: Double = 5
	static let requestPathExtension: String = ".js"
}

enum RequestPath {
	case status
	case developer

	var path: String {
		switch self {
		case .status: return "/system_status_"
		case .developer: return "/developer/system_status_"
		}
	}
}

struct StatusResource {
	private init() {}
	static var shared = StatusResource()

	var host = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus/data")) {
		$0.sessionConfiguration.timeoutIntervalForRequest = RequestConstant.timeoutInterval
	}

	var requestPath: RequestPath = .status
	var locale: String = Locale.current.identifier
}

extension StatusResource {
	func performRequest(_ requestPath: RequestPath) async throws -> Request<[Services]> {
		let request: Request<[Services]> = .get(requestPath.path + locale + RequestConstant.requestPathExtension)
		return request
	}

	func fetchServices() async throws -> [Services] {
		let services = try await host.send(performRequest(.status))

		guard services.statusCode == 200 else {
			Logger.statusResource.error("Request status code invalid: \(services.statusCode!, privacy: .private)")
			return []
		}

//			guard services.request.timeoutInterval == 5 else {
//					// show some alert
//					Logger.statusResource.error("Request time out: \(services.request.timeoutInterval, privacy: .private)")
//					return []
//			}

		return services.value
	}
}
