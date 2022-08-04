//
//  DeveloperList.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/22/22.
//

import OnflowNetwork
import SwiftUI

struct DeveloperView: View {
	@ObservedObject
	var model: DeveloperStatusViewModel

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
			.searchable(text: $model.searchText.animation(), prompt: Text("searchable-promptText"))
			.submitLabel(.search)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					SortListButton(toggleButton: $model.isFiltered.animation()) {
						model.developerEventsIsEmpty
					}
				}
			}
			.sheet(item: $currentDeveloperServices) { currentService in
				GenericSheetView(currentService, eventFor: .developer)
					.presentationDetents([.medium, .large])
			}
			.refreshable { await model.fetchServices() }
			.navigationTitle("navigation-developerTitle")
		}
	}
}

struct DeveloperView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = DeveloperStatusViewModel(onflowService: DeveloperStatusService())

		var body: some View {
			DeveloperView(model: model)
				.task { await model.fetchServices() }
		}
	}

	static var previews: some View {
//		@StateObject
//		private var model = DeveloperStatusViewModel(onflowService: DeveloperStatusService())
//		DeveloperList(model: model)
		Preview()
	}
}
