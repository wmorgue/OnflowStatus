//
//  ServiceListView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServicesView: View {

	@ObservedObject
	var model: ServiceViewModel

	var body: some View {
		switch model.isCompactView {
		case true: CompactServiceView()
		case false: ServiceListView(model: model)
		}
	}
}

struct CompactServiceView: View {
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

struct ServiceListView: View {

	@ObservedObject
	var model: ServiceViewModel

	@State
	private var searchText: String = ""

	@State
	private var isFilteredByEvents: Bool = false

	var body: some View {
		NavigationStack {
			List(filteredEvents) { service in
				ServiceRow(service)
					.onTapGesture { model.showSheet(for: service) }
			}
			.scrollIndicators(.never)
			.task { await model.fetchSupport() }
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						guard model.services.map(\.events).isEmpty else {
							isFilteredByEvents.toggle()
							return
						}
					} label: {
						Image(systemName: "arrow.up.arrow.down.square")
							.foregroundStyle(Color("FilterEventsButton"))
							.symbolRenderingMode(.hierarchical)
					}
				}
			}
			.refreshable { await model.fetchSupport() }
			.searchable(text: $searchText, prompt: Text("Enter service name"))
			.sheet(isPresented: $model.showingSheet) {
				ServiceSheetView(model: model)
					.presentationDetents([.medium, .large])
			}
			.navigationTitle("Support")
		}
	}
}

extension ServiceListView {
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
			ServicesView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
