//
//  MockDataServices.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.

import Foundation
import Get
import OnflowNetwork

struct MockStatusService: OnflowServiceProtocol {
	var host: APIClient = .init(baseURL: URL(string: "https://www.apple.com/support/systemstatus"))

	var requestPath: OnflowNetwork.RequestPath = .support

	var localeLayer: OnflowNetwork.LocaleLayer = .instance

	/// Request to Mock server
	func performRequest(_ requestPath: OnflowNetwork.RequestPath) -> Get.Request<OnflowNetwork.SupportStatus> {
		Request.get(requestPath.path + localeLayer.locale + RequestConstant.requestPathExtension)
	}

	/// Get data from JSON file
	func fetchServices() async throws -> [OnflowNetwork.Services] {
		guard let url = Bundle.main.url(forResource: "system_status_ru", withExtension: "json"),
		      let data = try? Data(contentsOf: url) else { return [] }

		let jsonDecoder = JSONDecoder()
		let apiResponse = try? jsonDecoder.decode(SupportStatus.self, from: data)

		return apiResponse?.services ?? []
	}
}
