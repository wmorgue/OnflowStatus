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

public struct SupportStatus {
	public var services: [Services]
}

public struct Services {
	public var serviceName: String
	public var redirectUrl: String?
	public var events: [Event]

	public init(serviceName: String, redirectUrl: String? = nil, events: [Event]) {
		self.serviceName = serviceName
		self.redirectUrl = redirectUrl
		self.events = events
	}
}

public struct Event {
	public var usersAffected: String?
	public var epochStartDate: Double
	public var epochEndDate: Double?
	public var messageID, statusType, datePosted, startDate: String
	public var endDate: String?
	public var affectedServices: [String?]?
	public var compactAffectedServices: [String]? {
		affectedServices?.compactMap { $0 }
	}

	public var eventStatus, message: String

	enum CodingKeys: String, CodingKey {
		case usersAffected, epochStartDate, epochEndDate
		case messageID = "messageId"
		case statusType, datePosted, startDate, endDate, affectedServices, eventStatus, message
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
