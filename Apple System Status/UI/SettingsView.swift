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

	private let mailToDeveloper = URL(string: "mailto:maybequantumbit@icloud.com")!

	private let telegramDeveloper = URL(string: "https://t.me/maybequantum")!

	var body: some View {
		NavigationStack {
			List {
				Section("Compact view") {
					Toggle("Enable compact style", isOn: $isCompactStyle)
				}

				Section("Send feedback via") {
					Link(destination: mailToDeveloper) {
						HStack {
							Text("E-mail")
							Spacer()
							Image(systemName: "paperclip.badge.ellipsis")
								.imageScale(.large)
						}
					}
					Link(destination: telegramDeveloper) {
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
