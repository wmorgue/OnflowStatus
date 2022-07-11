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

	@State
	private var isFilteredByEvents: Bool = false

//	@State
//	private var showingDevSheet: Bool = false

//	@State
//	var availableService: Services?

	var body: some View {
		NavigationStack {
			List(filteredEvents) { dev in
				DeveloperRow(dev) {
					model.setCircleColor(dev, message: .developer)
				}
//					.onTapGesture { model.showSheet(for: dev) }
			}
			.scrollIndicators(.never)
			.searchable(text: $searchText, prompt: Text("Enter service name"))
//			.sheet(isPresented: $model.showingDevSheet) {
//				DeveloperSheet(model: model)
//					.presentationDetents([.medium, .large])
//			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					SortListButton(toggleButton: $isFilteredByEvents) {
						model.developers.map(\.events).isEmpty
					}
				}
			}
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

	var filteredEvents: [Services] {
		isFilteredByEvents ? filteredServices.filter(\.events.isNotEmpty) : filteredServices
	}
}

struct DeveloperList_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceViewModel.preview

		var body: some View {
			DeveloperList(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
