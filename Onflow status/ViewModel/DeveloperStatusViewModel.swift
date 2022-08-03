//
//  DeveloperStatusViewModel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 8/3/22.
//

import OnflowNetwork
import SwiftUI

final class DeveloperStatusViewModel: ObservableObject {
	let onflowService: OnflowServiceProtocol

	@Published
	var systemData: [Services] = []

	@Published
	var showingAlert: Bool = false

	@Published
	var alertErrorMessage: String?

	@Published
	var showingSheet: Bool = false

	@Published
	var searchText: String = ""

	@Published
	var isFiltered: Bool = false

	@Published
	var currentSheetService: Services?

	init(onflowService: OnflowServiceProtocol) {
		self.onflowService = onflowService
	}
}

extension DeveloperStatusViewModel {
	var developerEventsIsEmpty: Bool { systemData.flatMap(\.events).isEmpty }

	var filteredDeveloperBySearchText: [Services] {
		searchText.isEmpty ? systemData : systemData.filter { $0.matches(searchText: searchText) }
	}

	var developerList: [Services] {
		isFiltered ? filteredDeveloperBySearchText.filter(\.events.isNotEmpty) : filteredDeveloperBySearchText
	}

	var alertMessageReason: Text {
		Text("alert-topMessage") + Text("\n") + Text(alertErrorMessage ?? "")
	}

	@MainActor
	func fetchServices() async {
		do {
			systemData = try await onflowService.fetchServices()
		} catch {
			print(error)
		}
	}
}
