//
//  SupportView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct SupportView: View {

	@ObservedObject
	var model: ServiceViewModel

	var body: some View {
		switch model.isCompactView {
		case true: CompactSupportView()
		case false: DefaultSupportListView(model: model)
		}
	}
}

struct CompactSupportView: View {
	var body: some View {
		NavigationStack {
			VStack {
				Image(systemName: "checkmark.circle")
					.font(.system(size: 48))
					.imageScale(.large)
					.foregroundColor(.green)

				Text("compactViewText")
					.font(.title3)
					.minimumScaleFactor(0.8)
			}
			.navigationTitle("navigation-systemTitle")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct DefaultSupportListView: View {

	@ObservedObject
	var model: ServiceViewModel

	var body: some View {
		NavigationStack {
			List(model.supportList) { service in
				SupportRow(service)
					.onTapGesture { model.showSheet(for: service) }
			}
			.scrollIndicators(.never)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					// Bug fixed, but need attention
					SortListButton(toggleButton: $model.isFilteredSupport.animation()) {
						model.supportEventsIsEmpty
					}
				}
			}
			.refreshable { await model.fetchSupport() }
			.searchable(text: $model.supportSearchText.animation(), prompt: Text("searchable-promptText"))
			.sheet(item: $model.currentSheetService) { service in
				GenericSheetView(service, eventFor: .support)
					.presentationDetents([.medium, .large])
			}
			.navigationTitle("navigation-systemTitle")
		}
	}
}

struct StatusListView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceViewModel.preview

		var body: some View {
			SupportView(model: model)
				.task { await model.fetchSupport() }
		}
	}

	static var previews: some View {
		Preview()
	}
}
