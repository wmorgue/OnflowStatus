//
//  ServiceListView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceListView: View {

	@StateObject var model = ServiceListModel()

	var body: some View {
		NavigationStack {
			List(model.services) { service in
				ServiceCellView(service)
//										.sheet(isPresented: $model.showingSheet) {
//												Text(service.serviceName)
					////												ServiceSheetView(service.serviceName, event: service.events)
//														.presentationDetents([.medium, .large])
//										}
					.onTapGesture { model.showSheet(for: service) }
			}
			.task { await model.getServices() }
			.refreshable { await model.getServices() }
			.navigationTitle("Support")
		}
	}
}

struct StatusListView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceListView()
	}
}
