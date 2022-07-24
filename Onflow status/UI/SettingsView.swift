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
					Toggle("settings-toggleCompactView", isOn: $model.isCompactView)
				} header: {
					Text("settings-compactView")
				} footer: {
					Text("settings-toggleFooter")
				}

				Section {
					Picker("settings-pickerRegion", selection: $localeLayer.locale) {
						ForEach(localeLayer.allLocales) { locale in
							Text(locale.rawValue)
								.tag(locale.identifier)
						}
					}
					.onChange(of: localeLayer.locale) { locale in
						model.dismissFilter
						model.updateLocale(for: locale)
						playSuccessHaptic()
						fetchUpdatedSupport()
					}
					.pickerStyle(.menu)
				} footer: {
					Text("settings-pickerFooter")
				}

				// App Icon — Default >
				NavigationLink {
					Text("settings-appIconPromt")
						.font(.title2)
						.fontWeight(.thin)
						.padding(.bottom, 80)

					HStack(spacing: 20) {
						VStack {
							AppIconButton(iconName: "DarkButtonIcon") {
								playSuccessHaptic()
								await model.chooseAppIcon(for: .dark)
							}
							Text("settings-appIconButtonDark")
						}
						VStack {
							AppIconButton(iconName: "LightButtonIcon") {
								playSuccessHaptic()
								await model.chooseAppIcon(for: .light)
							}
							Text("settings-appIconButtonLight")
						}
					}
					.bold()
				} label: {
					Text("settings-appIconLabel")
				}

				Section {
					Link(destination: DeveloperContact.mail) {
						Label("settings-mailSupport", systemImage: "paperclip.badge.ellipsis")
					}
					Link(destination: DeveloperContact.telegram) {
						Label("Telegram", systemImage: "paperplane.circle.fill")
					}
				} footer: {
					Text("\(Bundle.main.appName) \(appVersion) \(Bundle.main.appVersionLong)")
				}
				.labelStyle(.reversed)
				.symbolRenderingMode(.hierarchical)
				.foregroundColor(.primary)
				.imageScale(.large)
			}
			.scrollIndicators(.never)
			.navigationTitle("navigation-settingsTitle")
		}
	}
}

private extension SettingsView {
	var appVersion: Text {
		Text("settings-appVersion")
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
//			.environment(\.locale, .init(identifier: "ru"))
	}
}
