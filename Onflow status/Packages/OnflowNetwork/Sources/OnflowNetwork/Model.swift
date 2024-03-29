//
//  Support Status.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import Foundation

/*
 Support Status
 https://www.apple.com/support/systemstatus/data/system_status_en_US.js
 Developer Status
 https://www.apple.com/support/systemstatus/data/developer/system_status_en_US.js
 */

public struct SupportStatus: Sendable {
	public var services: [Services]
}

public struct Services: Sendable {
	public var serviceName: String
	public var redirectUrl: String?
	public var events: [Event]

	public init(serviceName: String, redirectUrl: String? = nil, events: [Event]) {
		self.serviceName = serviceName
		self.redirectUrl = redirectUrl
		self.events = events
	}
}

public struct Event: Sendable {
	public var usersAffected: String?
	public var epochStartDate: Double
	public var epochEndDate: Double?
	public var messageID: String
	public var affectedServices: [String?]?
	public var compactAffectedServices: [String]? {
		affectedServices?.compactMap { $0 }
	}

	public var eventStatus, message: String?

	enum CodingKeys: String, CodingKey {
		case usersAffected, epochStartDate, epochEndDate
		case messageID = "messageId"
		case affectedServices, eventStatus, message
	}

	public func affectedSeparator(_ services: [String]) -> String {
		guard !services.isEmpty else { return "Array is empy" }

		if services.count == 2 {
			return services.joined(separator: " and ")
		} else {
			return services.joined(separator: ", ")
		}
	}
}

extension SupportStatus: Decodable {}
extension Services: Decodable {}
extension Event: Decodable {}

extension Services: Identifiable {
	public var id: String { serviceName }

	public func matches(searchText: String) -> Bool {
		if id.localizedCaseInsensitiveContains(searchText) {
			return true
		}
		// Search service...
		return false
	}
}

extension Event: Identifiable {
	public var id: String { messageID }

	/// Showing relative localized date with capitalization
	public static func relativeNamedDate(epochDate: Double) -> String {
		let currentUnix = Date(timeIntervalSince1970: epochDate / 1000)
		return currentUnix.formatted(.relative(presentation: .named)).localizedCapitalized
	}
}
