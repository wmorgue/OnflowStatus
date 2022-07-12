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

	var body: some View {
		NavigationStack {
			List(model.developerList) { dev in
				DeveloperRow(dev) {
					model.setCircleColor(dev, message: .developer)
				}
			}
			.scrollIndicators(.never)
			.searchable(text: $model.developerSearchText, prompt: Text("Enter service name"))
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					SortListButton(toggleButton: $model.isFilteredByEvents) {
						model.developerEventsIsEmpty
					}
				}
			}
//			.task { await model.fetchDeveloper() }
			.refreshable { await model.fetchDeveloper() }
			.navigationTitle("Developer")
		}
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
