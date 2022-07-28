//
//  ColorExtension.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/10/22.
//

import SwiftUI

extension Color {
	static let sortEventsButton = Color("FilterEventsButton")

	static func setCircleColor(_ service: Services, message: EventStatusMessage) -> Color {
		service
			.events
			.map(\.eventStatus.localizedLowercase)
			.contains(message.text.lowercased()) || service.events.isEmpty ? .green : .orange
	}

	static func setCircleEventColor(_ event: Event, message: EventStatusMessage) -> Color {
		event
			.eventStatus
			.lowercased()
			.contains(message.text.lowercased()) ? Color.green : Color.orange
	}
}
