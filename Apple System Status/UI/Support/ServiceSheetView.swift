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

	var body: some View {
		List(model.services) { service in
			ForEach(service.events) { event in
				Section("Status") {
					// MARK: - Service name
					HStack {
						Text(service.serviceName)
						Spacer()
						Image(systemName: "checkmark.circle.fill")
							.foregroundColor(event.eventStatus.elementsEqual("ongoing") ? .orange : .green)
					}

					// MARK: - Relative date started
					HStack {
						Text("Event started")
						Spacer()
						Text(model.relativeStartDate(from: event.startDate))
							.foregroundColor(.secondary)
					}
				}
				// MARK: - Message to user
				Section {
					HStack {
						Text(event.message)
					}
				}
				// MARK: - Affected services
				if let affectedServices: [String] = event.affectedServices {
					Section("Affected services") {
						HStack {
							Text(String.affectedSeparator(affectedServices))
						}
					}
				}
			}
		}
	}
}

struct ServiceSheetView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject var model = ServiceListModel()
		var body: some View {
			ServiceSheetView(model: model)
				.task { await model.fetchSupport() }
		}
	}

	static var previews: some View {
		Preview()
	}
}
