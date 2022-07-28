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

	/*
	 {
	 										"usersAffected": "Some users are affected",
	 										"epochStartDate": 1658940000000,
	 										"epochEndDate": null,
	 										"messageId": "2000001581",
	 										"statusType": "Issue",
	 										"datePosted": "07/27/2022 10:48 PDT",
	 										"startDate": "07/27/2022 09:40 PDT",
	 										"endDate": null,
	 										"affectedServices": [
	 												"App Store Connect - App Processing ",
	 												"App Store Connect - App Upload"
	 										],
	 										"eventStatus": "ongoing",
	 										"message": "Users are experiencing a problem with this service. We are working to resolve this issue."
	 								},
	 								{
	 										"usersAffected": "Some users were affected",
	 										"epochStartDate": 1658868480000,
	 										"epochEndDate": 1658881620000,
	 										"messageId": "2000001579",
	 										"statusType": "Performance",
	 										"datePosted": "07/27/2022 10:48 PDT",
	 										"startDate": "07/26/2022 13:48 PDT",
	 										"endDate": "07/26/2022 17:27 PDT",
	 										"affectedServices": null,
	 										"eventStatus": "resolved",
	 										"message": "Users experienced a problem with this service."
	 								}
	 */
	static var developerService: Services {
		Services(
			serviceName: "App Store Connect - App Processing",
			redirectUrl: nil,
			events: [
				Event(usersAffected: "Some users are affected",
				      epochStartDate: 1_658_940_000_000,
				      epochEndDate: nil,
				      messageID: "2000001488",
				      statusType: "Issue",
				      datePosted: "07/27/2022 10:48 PDT",
				      startDate: "07/27/2022 09:40 PDT",
				      endDate: nil,
				      affectedServices: [
				      	"App Store Connect - App Processing ",
				      	"App Store Connect - App Upload",
				      ],
				      eventStatus: "ongoing",
				      message: "Users are experiencing a problem with this service. We are working to resolve this issue."),

				Event(usersAffected: "Some users were affected",
				      epochStartDate: 1_658_868_480_000,
				      epochEndDate: 1_658_881_620_000,
				      messageID: "2000001579",
				      statusType: "Performance",
				      datePosted: "07/27/2022 10:48 PDT",
				      startDate: "07/26/2022 13:48 PDT",
				      endDate: "07/26/2022 17:27 PDT",
				      affectedServices: nil,
				      eventStatus: "resolved",
				      message: "Users experienced a problem with this service."),
			]
		)
	}
}
