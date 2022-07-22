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
	private var currentDeveloperServices: Services?

	var body: some View {
		NavigationStack {
			List(model.developerList) { dev in
				DeveloperRow(dev)
					.onTapGesture {
						guard dev.events.isEmpty else {
							currentDeveloperServices = dev
							return
						}
					}
			}
			.scrollIndicators(.never)
			.searchable(text: $model.developerSearchText.animation(), prompt: Text("searchable-promptText"))
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					SortListButton(toggleButton: $model.isFilteredDeveloper.animation()) {
						model.developerEventsIsEmpty
					}
				}
			}
			.sheet(item: $currentDeveloperServices) { currentService in
				GenericSheetView(currentService, eventFor: .developer)
					.presentationDetents([.medium, .large])
			}
			.refreshable { await model.fetchDeveloper() }
			.navigationTitle("navigation-developerTitle")
		}
	}
}

struct DeveloperList_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceViewModel.preview

		var body: some View {
			DeveloperList(model: model)
				.task { await model.fetchDeveloper() }
		}
	}

	static var previews: some View {
		Preview()
	}
}
