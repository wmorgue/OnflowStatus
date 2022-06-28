//
//  SettingsView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/27/22.
//

import SwiftUI

struct SettingsView: View {
	@State
	private var isEnableNotification = false

	private let mailToDeveloper = URL(string: "mailto:maybequantumbit@icloud.com")!

	private let telegramDeveloper = URL(string: "https://t.me/maybequantum")!

	var body: some View {
		NavigationView {
			List {
				Section("Notification") {
					Toggle("Enable notifications", isOn: $isEnableNotification)
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
			.navigationTitle(Text(Date.now, format: .dateTime.day().month()))
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
