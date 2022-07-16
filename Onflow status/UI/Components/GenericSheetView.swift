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
						Text("Status")
					} icon: {
						Image(systemName: "checkmark.circle.fill")
							.foregroundColor(.setCircleColor(services, message: eventFor))
					}
					.labelStyle(.reversed)

					ForEach(services.events) { event in

						HStack {
							Text("Event started")
							Spacer()
							Text(relativeNamedDate(epochDate: event.epochStartDate).capitalized)
								.foregroundColor(.secondary)
						}

						if let eventEndDate = event.epochEndDate {
							HStack {
								Text("Event ended")
								Spacer()
								Text(relativeNamedDate(epochDate: eventEndDate).capitalized)
									.foregroundColor(.secondary)
							}
						}

						HStack {
							Text("Resolution")
							Spacer()
							Text(event.eventStatus.capitalized)
								.foregroundColor(.secondary)
						}

						Text(event.message)
					}
				}

				ForEach(services.events) { event in
					if let affectedServices: [String] = event.affectedServices {
						Section("Affected services") {
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

extension GenericSheetView {
	// TODO: - Move outside view and test with different time zone
	func relativeNamedDate(epochDate: Double) -> String {
		let currentUnix = Date(timeIntervalSince1970: epochDate / 1000)
		return currentUnix.formatted(.relative(presentation: .named))
	}
}

struct ServiceSheetView_Previews: PreviewProvider {
	static var previews: some View {
		GenericSheetView(MockData.developerService, eventFor: .developer)
	}
}
