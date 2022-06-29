//
//  ServiceListView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

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
