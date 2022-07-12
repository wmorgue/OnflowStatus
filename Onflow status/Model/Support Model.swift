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

struct SupportStatus {
	var services: [Services]
}

struct Services {
	var serviceName: String
	var redirectUrl: String?
	var events: [Event]
}

struct Event {
	var usersAffected: String?
	var epochStartDate: Int
	var epochEndDate: Int?
	var messageID, statusType, datePosted, startDate: String
	var endDate: String?
	var affectedServices: [String]?
	var eventStatus, message: String

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
	var id: String { serviceName }

	func matches(searchText: String) -> Bool {
		if id.localizedCaseInsensitiveContains(searchText) {
			return true
		}
		// Search service...
		return false
	}
}

extension Event: Identifiable {
	var id: String { messageID }
}
