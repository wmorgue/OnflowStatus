//
//  DeveloperSheet.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/28/22.
//

import SwiftUI

struct DeveloperSheet: View {
	@ObservedObject
	var model: ServiceViewModel

	var body: some View {
		List(model.developers) { service in
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
//						Text(model.relativeStartDate(from: event.startDate))
							.foregroundColor(.secondary)
					}
					HStack {
						Text("Resolution")
						Spacer()
						Text(event.eventStatus.capitalized)
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

struct DeveloperSheet_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject var model = ServiceViewModel()
		var body: some View {
			DeveloperSheet(model: model)
				.task { await model.fetchDeveloper() }
		}
	}

	static var previews: some View {
		Preview()
	}
}
