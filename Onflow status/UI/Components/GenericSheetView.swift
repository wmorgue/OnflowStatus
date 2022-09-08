//
//  GenericSheetView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import OnflowNetwork
import SwiftUI
import UniformTypeIdentifiers

struct GenericSheetView: View {

	var services: Services
	var eventFor: EventStatusMessage

	@Environment(\.dismiss)
	private var closeSheet

	init(_ services: Services, eventFor: EventStatusMessage) {
		self.services = services
		self.eventFor = eventFor
	}

	var body: some View {
		NavigationStack {
			List {
				ForEach(services.events) { event in
					Section {
						StatusLabel(event, eventFor)
						EventStarted(event.epochStartDate)
						EventEnded(event)
						EventResolution(event)
						EventMessage(event.message)
					}
				}
				AffectedServices(services.events)
			}
			.navigationBarTitle(services.serviceName, displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					if let redirectURL = services.redirectUrl {
						ShareLink(item: redirectURL)
					}
				}

				ToolbarItem(placement: .navigationBarTrailing) {
					closeSheetButton
				}
			}
		}
	}
}

extension GenericSheetView {
	private var closeSheetButton: some View {
		Button {
			closeSheet()
		} label: {
			Image(systemName: "xmark.app.fill")
				.imageScale(.large)
				.foregroundColor(.secondary)
		}
	}
}

fileprivate struct EventStarted: View {

	let startDate: Double

	init(_ startDate: Double) { self.startDate = startDate }

	var body: some View {
		HStack {
			Text("genericSheet-eventStarted")
			Spacer()
			Text(Event.relativeNamedDate(epochDate: startDate))
				.foregroundColor(.secondary)
		}
	}
}

fileprivate struct StatusLabel: View {

	let event: Event
	let eventFor: EventStatusMessage

	init(_ event: Event, _ eventFor: EventStatusMessage) {
		self.event = event
		self.eventFor = eventFor
	}

	var body: some View {
		Label {
			Text("genericSheet-status")
		} icon: {
			Image(systemName: "checkmark.circle.fill")
				.foregroundColor(.setCircleEventColor(event, message: eventFor))
		}
		.labelStyle(.reversed)
	}
}

fileprivate struct EventEnded: View {

	let event: Event

	init(_ event: Event) {
		self.event = event
	}

	var body: some View {
		if let eventEndDate = event.epochEndDate {
			HStack {
				Text("genericSheet-eventEnded")
				Spacer()
				Text(Event.relativeNamedDate(epochDate: eventEndDate))
					.foregroundColor(.secondary)
			}
		}
	}
}

fileprivate struct EventResolution: View {

	let event: Event

	init(_ event: Event) {
		self.event = event
	}

	var body: some View {
		HStack {
			Text("genericSheet-eventResolution")
			Spacer()
			// TODO:
			Text(event.eventStatus?.localizedCapitalized ?? "N/A")
				.foregroundColor(.secondary)
		}
	}
}

fileprivate struct EventMessage: View {
	let message: String?

	init(_ message: String?) {
		self.message = message
	}

	var body: some View {
		if let message {
			Text(message)
				.contextMenu {
					Button {
						UIPasteboard.general.setValue(message, forPasteboardType: UTType.plainText.identifier)
					} label: {
						Label("Copy to clipboard", systemImage: "doc.on.clipboard.fill")
					}
				}
		}
	}
}

fileprivate struct AffectedServices: View {

	let events: [Event]

	init(_ events: [Event]) {
		self.events = events
	}

	var body: some View {
		ForEach(events) { event in
			if let affectedServices: [String] = event.compactAffectedServices {
				Section("genericSheet-affectedServices") {
					HStack {
						Text(event.affectedSeparator(affectedServices))
					}
				}
			}
		}
	}
}

struct GenericSheetView_Previews: PreviewProvider {
	static var previews: some View {
		GenericSheetView(Services(serviceName: "MockData Service", events: []), eventFor: .developer)
	}
}
