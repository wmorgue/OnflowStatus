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

				Text("All services are operating normally.")
					.font(.title3)
					.minimumScaleFactor(0.8)
			}
			.navigationTitle("Support")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct DefaultSupportListView: View {

	@ObservedObject
	var model: ServiceViewModel

	@State
	private var searchText: String = ""

	@State
	private var isFilteredByEvents: Bool = false

	var body: some View {
		NavigationStack {
			List(filteredEvents) { service in
				SupportRow(service) {
					model.setCircleColor(service, message: .support)
				}
				.onTapGesture { model.showSheet(for: service) }
			}
			.scrollIndicators(.never)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					// Bug fixed, but need attention
					SortListButton(toggleButton: $isFilteredByEvents) {
						model.supportEventsIsEmpty
					}
				}
			}
			.refreshable { await model.fetchSupport() }
			.searchable(text: $searchText, prompt: Text("Enter service name"))
			.sheet(isPresented: $model.showingSheet) {
				SupportSheetView(model: model)
					.presentationDetents([.medium, .large])
			}
			.navigationTitle("Support")
		}
	}
}

extension DefaultSupportListView {
	var filteredServices: [Services] {
		searchText.isEmpty ? model.services : model.services.filter { $0.matches(searchText: searchText) }
	}

	var filteredEvents: [Services] {
		isFilteredByEvents ? filteredServices.filter(\.events.isNotEmpty) : filteredServices
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
