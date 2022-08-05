import Foundation
import Get
import OSLog

private extension Logger {
	static var onflowNetwork: Logger {
		Logger(subsystem: String(describing: OnflowServiceProtocol.self), category: String(describing: OnflowServiceProtocol.self))
	}
}

/// Onflow Service Protocol that create a network request
public protocol OnflowServiceProtocol {
	var host: APIClient { get }
	var requestPath: RequestPath { get }
	var localeLayer: LocaleLayer { get }

	func performRequest(_ requestPath: RequestPath) -> Request<SupportStatus>
	func fetchServices() async throws -> [Services]
}

public enum RequestConstant {
	static let timeoutInterval: Double = 5
	static let requestPathExtension: String = ".js"
}

public enum RequestPath {
	case support
	case developer

	var path: String {
		switch self {
		case .support: return "/data/system_status_"
		case .developer: return "/data/developer/system_status_"
		}
	}
}

// Apply to SystemStatusViewModel
public struct SystemStatusService: OnflowServiceProtocol {

	public init() {}

	public var host = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus")) {
		$0
			.sessionConfiguration
			.timeoutIntervalForRequest = RequestConstant.timeoutInterval
	}

	public var requestPath: RequestPath = .support
	public var localeLayer: LocaleLayer = .instance

	public func performRequest(_ requestPath: RequestPath) -> Request<SupportStatus> {
		Request.get(requestPath.path + localeLayer.locale + RequestConstant.requestPathExtension)
	}

	public func fetchServices() async throws -> [Services] {
		#if targetEnvironment(simulator)
			Logger.onflowNetwork.debug("💡\(String(describing: SystemStatusService.self)) | Called \(#function). Current locale: \(localeLayer.locale)")
		#endif
		let systemStatus = try await host.send(performRequest(.support))

		// Move to Unit Testing?
		guard systemStatus.statusCode == 200 else {
			Logger.onflowNetwork.error("🚨 Request status code invalid: \(systemStatus.statusCode!, privacy: .private)")
			throw URLError(.cannotConnectToHost)
		}
		return systemStatus.value.services
	}
}

// Apply to DeveloperStatusViewModel
public struct DeveloperStatusService: OnflowServiceProtocol {

	public init() {}

	public var host = APIClient(baseURL: URL(string: "https://www.apple.com/support/systemstatus")) {
		$0
			.sessionConfiguration
			.timeoutIntervalForRequest = RequestConstant.timeoutInterval
	}

	public var requestPath: RequestPath = .developer
	public var localeLayer: LocaleLayer = .instance

	public func performRequest(_ requestPath: RequestPath) -> Request<SupportStatus> {
		Request.get(requestPath.path + localeLayer.developerLocale + RequestConstant.requestPathExtension)
	}

	public func fetchServices() async throws -> [Services] {
		var stringRequest: Request<String> {
			.get(RequestPath.developer.path + localeLayer.developerLocale + RequestConstant.requestPathExtension)
		}
		var callbackJSON: String = try await host
			.send(stringRequest)
			.value
			.trimmingCharacters(in: .whitespacesAndNewlines)

		callbackJSON.removeFirst(13)
		callbackJSON.removeLast(2)

		let resultData: Data = callbackJSON.data(using: .utf8)!

		let isValidObject: Bool = JSONSerialization.isValidJSONObject(resultData)

		guard !isValidObject else {
			Logger.onflowNetwork.error("🚨 Invalid JSON: \(#function)")
			throw URLError(.cannotDecodeContentData)
		}

		#if targetEnvironment(simulator)
			Logger.onflowNetwork.debug("💡\(String(describing: DeveloperStatusService.self)) | Called \(#function)")
		#endif

		let status: SupportStatus = try JSONDecoder().decode(SupportStatus.self, from: resultData)
		return status.services
	}
}
