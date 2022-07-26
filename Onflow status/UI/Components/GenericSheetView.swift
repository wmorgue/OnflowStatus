//
//  GenericSheetView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

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
				Section {
					Label {
						Text("genericSheet-status")
					} icon: {
						Image(systemName: "checkmark.circle.fill")
							.foregroundColor(.setCircleColor(services, message: eventFor))
					}
					.labelStyle(.reversed)

					ForEach(services.events) { event in

						HStack {
							Text("genericSheet-eventStarted")
							Spacer()
							Text(event.relativeNamedDate(epochDate: event.epochStartDate))
								.foregroundColor(.secondary)
						}

						if let eventEndDate = event.epochEndDate {
							HStack {
								Text("genericSheet-eventEnded")
								Spacer()
								Text(event.relativeNamedDate(epochDate: eventEndDate))
									.foregroundColor(.secondary)
							}
						}

						HStack {
							Text("genericSheet-eventResolution")
							Spacer()
							Text(event.eventStatus.capitalized)
								.foregroundColor(.secondary)
						}

						Text(event.message)
					}
				}

				ForEach(services.events) { event in
					if let affectedServices: [String] = event.affectedServices {
						Section("genericSheet-affectedServices") {
							HStack {
								Text(String.affectedSeparator(affectedServices))
							}
						}
					}
				}
			}
			.navigationBarTitle(services.serviceName, displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						closeSheet()
					} label: {
						Image(systemName: "xmark.app.fill")
							.foregroundColor(.secondary)
					}
				}
			}
//			.toolbarTitleMenu {
//				Text("123")
//			}
		}
	}
}

struct ServiceSheetView_Previews: PreviewProvider {
	static var previews: some View {
		GenericSheetView(MockData.developerService, eventFor: .developer)
	}
}
