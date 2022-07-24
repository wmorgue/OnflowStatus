//
//  NetworkLayer.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/26/22.
//

import Foundation
import Get
import OSLog

private extension Logger {
	static var statusResource: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: NetworkLayer.self))
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

struct NetworkLayer {
	private var host = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus/data")) {
		$0
			.sessionConfiguration
			.timeoutIntervalForRequest = RequestConstant.timeoutInterval
	}

	private var requestPath: RequestPath = .support
	var supportLocale: String = LocaleLayer.shared.locale
//	private(set) var supportLocale: String = LocaleLayer.shared.locale
	private(set) var developerLocale: String = CurrentLocale.english.identifier
}

extension NetworkLayer {
	private func debugDump<T>(_ value: T) -> Void {
		#if targetEnvironment(simulator)
			dump(value, indent: 2)
		#endif
	}

	private func performRequest(_ requestPath: RequestPath) -> Request<SupportStatus> {
		Request.get(requestPath.path + supportLocale + RequestConstant.requestPathExtension)
	}

	private func performCallbackRequest(_ requestPath: RequestPath) -> Request<String> {
		Request.get(requestPath.path + developerLocale + RequestConstant.requestPathExtension)
	}

	func fetchSupportServices() async throws -> [Services] {
		#if targetEnvironment(simulator)
			Logger.statusResource.debug("Called \(#function). Locale: \(supportLocale)")
		#endif
		let supportStatus = try await host.send(performRequest(.support))

		guard supportStatus.statusCode == 200 else {
			Logger.statusResource.error("Request status code invalid: \(supportStatus.statusCode!, privacy: .private)")
			throw URLError(.cannotConnectToHost)
		}
		return supportStatus.value.services
	}

	func fetchDeveloperServices() async throws -> [Services] {
		var callbackResult: String = try await host
			.send(performCallbackRequest(.developer))
			.value
			.trim

		callbackResult.removeFirst(13)
		callbackResult.removeLast(2)

		let resultData: Data = callbackResult.data(using: .utf8)!

		let isValidObject: Bool = JSONSerialization.isValidJSONObject(resultData)

		guard !isValidObject else {
			Logger.statusResource.error("Invalid JSON: \(#function)")
			throw URLError(.cannotDecodeContentData)
		}

		let status: SupportStatus = try JSONDecoder().decode(SupportStatus.self, from: resultData)
		return status.services
	}
}
