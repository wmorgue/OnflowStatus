//
//  DeveloperList.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/22/22.
//

import SwiftUI

struct DeveloperList: View {
	@ObservedObject
	var model: ServiceViewModel

	@State
	private var searchText: String = ""

//	@State
//	var availableService: Services?

	var body: some View {
		NavigationStack {
			List(filteredServices) { dev in
//				DevRow(service: dev)
				DeveloperRow(service: dev)
			}
			.scrollIndicators(.never)
			.searchable(text: $searchText, prompt: Text("Enter service name"))
			.task { await model.fetchDeveloper() }
			.refreshable { await model.fetchDeveloper() }
			.navigationTitle("Developer")
		}
	}
}

extension DeveloperList {
	var filteredServices: [Services] {
		searchText.isEmpty ? model.developers : model.developers.filter { $0.matches(searchText: searchText) }
	}
}

struct DeveloperList_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceViewModel.preview

		var body: some View {
			ServiceListView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
