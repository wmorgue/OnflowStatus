//
//  SettingsView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/27/22.
//

import SwiftUI

struct SettingsView: View {
	@State
	private var isCompactStyle = false

	var body: some View {
		NavigationStack {
			List {
				Section("Compact view") {
					Toggle("Enable compact style", isOn: $isCompactStyle)
						.disabled(true)
				}

				Section("Support") {
					Link(destination: DeveloperContact.mail) {
						HStack {
							Text("Contact Support")
							Spacer()
							Image(systemName: "paperclip.badge.ellipsis")
								.imageScale(.large)
						}
					}
					Link(destination: DeveloperContact.telegram) {
						HStack {
							Text("Telegram")
							Spacer()
							Image(systemName: "paperplane.circle")
								.imageScale(.large)
						}
					}
				}
			}
			.scrollIndicators(.never)
			.navigationTitle(navigationText)
		}
	}
}

private extension SettingsView {
	var navigationText: Text {
		Text(Date.now, format: .dateTime.day().month())
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
