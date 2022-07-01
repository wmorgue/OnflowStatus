//
//  ServiceListView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServicesView: View {

	@ObservedObject
	var model: ServiceListModel

	var body: some View {
		switch model.isCompactView {
		case true: CompactServiceView()
		case false: ServiceListView(model: model)
		}
	}
}

struct CompactServiceView: View {
	var body: some View {
		Label {
			Text("All services are operating normally.")
				.lineLimit(1)
				.minimumScaleFactor(0.8)
		} icon: {
			Image(systemName: "circle.dotted")
				.foregroundColor(.green)
		}
	}
}

struct ServiceListView: View {

	@ObservedObject
	var model: ServiceListModel

	@State
	private var searchText: String = ""

	var body: some View {
		NavigationStack {
			List(filteredServices) { service in
				ServiceRow(service)
					.onTapGesture { model.showSheet(for: service) }
			}
			.scrollIndicators(.never)
			.task { await model.fetchSupport() }
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
}

struct StatusListView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceListModel.preview

		var body: some View {
			ServiceListView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
