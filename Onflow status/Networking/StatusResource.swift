//
//  StatusResource.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/26/22.
//

import Foundation
import Get
import OSLog

private extension Logger {
	static var statusResource: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: StatusResource.self))
	}
}

private enum RequestConstant {
	static let timeoutInterval: Double = 5
	static let requestPathExtension: String = ".js"
}

enum RequestPath {
	case support
	case developer

	var path: String {
		switch self {
		case .support: return "/system_status_"
		case .developer: return "/developer/system_status_"
		}
	}
}

struct StatusResource {
	private var host = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus/data")) {
		$0.sessionConfiguration.timeoutIntervalForRequest = RequestConstant.timeoutInterval
	}

	private var requestPath: RequestPath = .support
	private(set) var locale: String = "en_US"
//	private(set) var locale: String = Locale.current.identifier
}

extension StatusResource {
	private func debugDump<T>(_ value: T) -> Void {
		#if targetEnvironment(simulator)
			dump(value, indent: 2)
		#endif
	}

	private func performRequest(_ requestPath: RequestPath) async throws -> Request<SupportStatus> {
		let request: Request<SupportStatus> = .get(requestPath.path + locale + RequestConstant.requestPathExtension)
		return request
	}

	private func performCallbackRequest(_ requestPath: RequestPath) async throws -> Request<Data> {
		let request: Request<Data> = .get(requestPath.path + locale + RequestConstant.requestPathExtension)
		return request
	}

	func fetchSupportServices() async throws -> [Services] {
		let supportStatus = try await host.send(performRequest(.support))

		guard supportStatus.statusCode == 200 else {
			Logger.statusResource.error("Request status code invalid: \(supportStatus.statusCode!, privacy: .private)")
			return []
		}
		return supportStatus.value.services
	}

	func fetchDeveloperServices() async throws -> [Services] {
		var callbackResult: Data = try await host.send(performCallbackRequest(.developer)).data
		callbackResult.removeFirst(13)
		callbackResult.removeLast(2)

//		print(callbackResult)
//		let resultData = callbackResult.data(using: .utf8)!

		let isValidObject: Bool = JSONSerialization.isValidJSONObject(callbackResult)

		guard !isValidObject else {
			Logger.statusResource.error("Invalid JSON: \(#function)")
			return []
		}

		let status: SupportStatus = try JSONDecoder().decode(SupportStatus.self, from: callbackResult)
		return status.services
	}
}
