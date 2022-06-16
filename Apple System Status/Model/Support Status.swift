//
//  Support Status.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import Foundation

// Support Status
// https://www.apple.com/support/systemstatus/data/system_status_en_US.js

struct SupportStatus {
	let services: [Services]
}

struct Services {
	var serviceName: String
	var redirectUrl: String?
	var events: [Event]?
}

struct Event {
	let usersAffected: String
	let epochStartDate: Int
	let epochEndDate: Int?
	let messageID, statusType, datePosted, startDate: String
	let endDate: String?
	let affectedServices: [String]?
	let eventStatus, message: String

	enum CodingKeys: String, CodingKey {
		case usersAffected, epochStartDate, epochEndDate
		case messageID = "messageId"
		case statusType, datePosted, startDate, endDate, affectedServices, eventStatus, message
	}
}

// extension Services {
//				static var previewDataJSON: [Services] {
//								let previewDataURL = Bundle.main.url(forResource: "system_status_ru", withExtension: "json")!
//								let jsonDecoder = JSONDecoder()
//
//								let data = try! Data(contentsOf: previewDataURL)
//								let apiResponse = try! jsonDecoder.decode(SupportStatus.self, from: data)
//
//								return apiResponse.services
//				}
// }

// extension Event {
//				static var localData: [Event] {
//								[Event(
//												usersAffected: "Затронуты некоторые пользователи",
//												epochStartDate: 1647880020000,
//												epochEndDate: nil,
//												messageID: "2000001303",
//												statusType: "Outage",
//												datePosted: "21.03.2022 17:58 GMT",
//												startDate: "21.03.2022 16:27 GMT",
//												endDate: nil,
//												affectedServices: [
//																"iCloud Drive",
//																"Веб-приложения iCloud (iCloud.com)",
//																"Календарь iCloud",
//																"Почта iCloud",
//																"Связка ключей iCloud",
//																"Учетная запись и вход в iCloud"
//												],
//												eventStatus: "ongoing",
//												message: "Возможно, нет доступа к календарям из веб-приложения «Календарь» на icloud.com."
//								)]
//				}
// }

extension SupportStatus: Decodable {}
extension Services: Decodable {}
extension Event: Decodable {}

extension Services: Identifiable {
	var id: String { serviceName }
}

extension Event: Identifiable {
	var id: String { messageID }
}
