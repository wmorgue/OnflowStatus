//
//  ServiceSheetView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceSheetView: View {

	@ObservedObject
	var model: ServiceListModel
	//	var serviceName: String
	//	var event: [Event]

	//	init(_ serviceName: String, event: [Event]) {
	//		self.serviceName = serviceName
	//		self.event = event
	//	}

	var body: some View {
		VStack {
			ForEach(model.services) { service in
				//								Text(service.serviceName)
				ForEach(service.events) { event in
					Text(event.eventStatus.capitalized)
					Text(event.message)
				}
				//								HStack {
				//										Text(service.serviceName)
				//						+
				//						Text(event.eventStatus.capitalized)
				//						.foregroundColor(event.eventStatus.contains("ongoing") ? .orange : .green)
				//								}
				//
				//				Text(event.startDate)
				//					.padding(.bottom)
				//
				//				VStack(alignment: .leading) {
				//					Text(event.message)
				//					Text(event.usersAffected)
				// AffectedServices View
			}
		}
	}
}

struct ServiceSheetView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject var model = ServiceListModel()
		var body: some View {
			ServiceSheetView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
