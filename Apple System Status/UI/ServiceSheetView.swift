//
//  ServiceSheetView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceSheetView: View {
	var serviceName: String
	var event: [Event]

	init(_ serviceName: String, event: [Event]) {
		self.serviceName = serviceName
		self.event = event
	}

	var body: some View {
		VStack {
			ForEach(event) { event in
				HStack {
					Text("\(serviceName) - ")
						+
						Text(event.eventStatus.capitalized)
						.foregroundColor(event.eventStatus.contains("ongoing") ? .orange : .green)
				}

				Text(event.startDate)
					.padding(.bottom)

				VStack(alignment: .leading) {
					Text(event.message)
					Text(event.usersAffected)
					// AffectedServices View
				}
			}
		}
	}
}

struct ServiceSheetView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceSheetView("iCloud", event: MockData.events)
	}
}
