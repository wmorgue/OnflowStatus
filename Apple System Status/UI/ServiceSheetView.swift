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

	var body: some View {
		VStack {
			ForEach(model.services) { service in
				ForEach(service.events) { event in
					HStack {
						Text("\(service.serviceName)  -")
						Text(event.eventStatus.capitalized)
							.foregroundColor(event.eventStatus.contains("ongoing") ? .orange : .green)
					}
					.bold()
					.padding(.bottom)

					VStack(alignment: .leading) {
						Text(event.usersAffected)
						Text(event.message)
					}
				}
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
