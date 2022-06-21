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

	var body: some View {
		NavigationStack {
			List(model.services) { service in
				ServiceRow(service)
					.onTapGesture { model.showSheet(for: service) }
			}
			.task { await model.getServices() }
			.refreshable { await model.getServices() }
			.navigationTitle("Support")
			.sheet(isPresented: $model.showingSheet) {
				ServiceSheetView(model: model)
					.presentationDetents([.medium, .large])
			}
		}
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
