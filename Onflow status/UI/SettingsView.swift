//
//  SettingsView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/27/22.
//

import SwiftUI

fileprivate struct AppIconButton: View {

	let iconName: String
	let asyncTask: ClosureAsyncAction

	var body: some View {
		Button {
			Task { @MainActor in await asyncTask() }
		} label: {
			Image(iconName)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 130, height: 130)
				.cornerRadius(22)
		}
		.buttonStyle(.bordered)
		.controlSize(.large)
	}
}

struct SettingsView: View {
	@StateObject
	var model = ServiceViewModel()

	@StateObject
	var localeLayer = LocaleLayer.shared

	var body: some View {
		NavigationStack {
			List {
				Section {
					Toggle("Enable compact style", isOn: $model.isCompactView)
				} header: {
					Text("Compact view")
				} footer: {
					Text("Only for support tab.")
				}

				Section {
					Picker("Region language", selection: $localeLayer.locale) {
						ForEach(localeLayer.allLocales) { locale in
							Text(locale.rawValue)
								.tag(locale.identifier)
						}
					}
					.onChange(of: localeLayer.locale) { locale in
						model.updateLocale(for: locale)
						fetchUpdatedSupport()
					}
					.pickerStyle(.menu)
				} footer: {
					Text("You can set your region preference. Available only for support tab.")
				}

				// App Icon — Default >
				NavigationLink {
					Text("Choose light or dark app icon")
						.font(.title2)
						.fontWeight(.thin)
						.padding(.bottom, 80)

					HStack(spacing: 20) {
						VStack {
							AppIconButton(iconName: "DarkButtonIcon") {
								playSuccessHaptic()
								await model.chooseAppIcon(for: .dark)
							}
							Text("Dark")
						}
						VStack {
							AppIconButton(iconName: "LightButtonIcon") {
								playSuccessHaptic()
								await model.chooseAppIcon(for: .light)
							}
							Text("Light")
						}
					}
					.bold()
				} label: {
					Text("App Icon")
				}

				Section {
					Link(destination: DeveloperContact.mail) {
						Label("Contact Support", systemImage: "paperclip.badge.ellipsis")
					}
					Link(destination: DeveloperContact.telegram) {
						Label("Telegram", systemImage: "paperplane.circle.fill")
					}
				} footer: {
					Text("\(Bundle.main.appName) Version \(Bundle.main.appVersionLong)")
				}
				.labelStyle(.reversed)
				.symbolRenderingMode(.hierarchical)
				.foregroundColor(.primary)
				.imageScale(.large)
			}
			.scrollIndicators(.never)
			.navigationTitle(navigationText)
		}
	}
}

private extension SettingsView {
	var navigationText: Text {
		Text("Settings")
	}

	func fetchUpdatedSupport() {
		Task { @MainActor in
			await model.fetchSupport()
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		//		AppIconButton()
		SettingsView(model: ServiceViewModel())
	}
}
