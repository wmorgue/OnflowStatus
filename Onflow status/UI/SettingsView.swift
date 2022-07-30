//
//  SettingsView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/27/22.
//

import SwiftUI

struct SettingsView: View {
	@StateObject
	var model = ServiceViewModel()

	@StateObject
	var localeLayer = LocaleLayer.instance

	var body: some View {
		NavigationStack {
			List {
				CompactToggle(isCompact: $model.isCompactView)
				RegionPicker(
					locale: $localeLayer.locale,
					model: model,
					allLocales: localeLayer.allLocales
				)
				ApplicationIcon(model: model)
				ContactSupport(appVersion: appVersion)
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
}

private extension RegionPicker {
	func fetchUpdatedSupport() {
		Task { @MainActor in
			await model.fetchSupport()
		}
	}
}

fileprivate struct AppIconButton: View {

	let iconName: String
	let asyncTask: ClosureAsyncAction

	var body: some View {
		Button {
			Task { await asyncTask() }
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

fileprivate struct CompactToggle: View {

	@Binding
	var isCompact: Bool

	var body: some View {
		Section {
			Toggle("settings-toggleCompactView", isOn: $isCompact)
		} header: {
			Text("settings-compactView")
		} footer: {
			Text("settings-toggleFooter")
		}
	}
}

fileprivate struct RegionPicker: View {

	@Binding
	var locale: String

	@ObservedObject
	var model: ServiceViewModel

	let allLocales: [CurrentLocale]

	var body: some View {
		Section {
			Picker("settings-pickerRegion", selection: $locale) {
				ForEach(allLocales) { locale in
					Text(locale.rawValue)
						.tag(locale.identifier)
				}
			}
			.onChange(of: locale) { locale in
				model.dismissFilter
				model.updateLocale(for: locale)
				playSuccessHaptic()
				fetchUpdatedSupport()
			}
			.pickerStyle(.menu)
		} footer: {
			Text("settings-pickerFooter")
		}
	}
}

fileprivate struct ContactSupport: View {

	let appVersion: Text

	var body: some View {
		Section {
			// TODO: - Issue #10 in Github
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
}

fileprivate struct ApplicationIcon: View {

	@ObservedObject
	var model: ServiceViewModel

	var body: some View {
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
	}
}

// MARK: - Canvas Preview
struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(model: ServiceViewModel())
//			.environment(\.locale, .init(identifier: "ru"))
	}
}
