//
//  MockData.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import Foundation

enum MockData {
	static var events: [Event] {
		[Event(
			usersAffected: "Затронуты некоторые пользователи",
			epochStartDate: 1_647_880_020_000,
			epochEndDate: nil,
			messageID: "2000001303",
			statusType: "Outage",
			datePosted: "21.03.2022 17:58 GMT",
			startDate: "21.03.2022 16:27 GMT",
			endDate: nil,
			affectedServices: [
				"iCloud Drive",
				"Веб-приложения iCloud (iCloud.com)",
				"Календарь iCloud",
				"Почта iCloud",
				"Связка ключей iCloud",
				"Учетная запись и вход в iCloud",
			],
			eventStatus: "ongoing",
			message: "Возможно, нет доступа к календарям из веб-приложения «Календарь» на icloud.com."
		)]
	}

	static var servicesJSON: [Services] {
		guard let url = Bundle.main.url(forResource: "system_status_ru", withExtension: "json"),
		      let data = try? Data(contentsOf: url) else { return [] }

		let jsonDecoder = JSONDecoder()
		let apiResponse = try? jsonDecoder.decode(SupportStatus.self, from: data)

		return apiResponse?.services ?? []
	}

	static var developerService: Services {
		Services(
			serviceName: "Developer ID Notary Service",
			redirectUrl: nil,
			events: [Event(
				usersAffected: "Some users were affected",
				epochStartDate: 1_654_879_800_000,
				epochEndDate: 1_654_906_200_000,
				messageID: "2000001488",
				statusType: "Issue",
				datePosted: "06/12/2022 06:00 PDT",
				startDate: "06/10/2022 09:50 PDT",
				endDate: "06/10/2022 17:10 PDT",
				affectedServices: [
					"iCloud Drive",
					"Веб-приложения iCloud (iCloud.com)",
					"Календарь iCloud",
					"Почта iCloud",
					"Связка ключей iCloud",
					"Учетная запись и вход в iCloud",
				],
				eventStatus: "completed",
				message: "Users may have experienced issues with the service."
			)]
		)
	}
}
