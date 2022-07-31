//
//  NavigationTabView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

fileprivate enum NavigationItem {
	case support
	case developer
	case settings

	static let systemTitle = String(localized: "navigation-systemTitle")
	static let developerTitle = String(localized: "navigation-developerTitle")
	static let settingsTitle = String(localized: "navigation-settingsTitle")

	var label: some View {
		switch self {
		case .support: return Label(Self.systemTitle, systemImage: "rectangle.stack")
		case .developer: return Label(Self.developerTitle, systemImage: "hammer")
		case .settings: return Label(Self.settingsTitle, systemImage: "gear")
		}
	}
}

struct NavigationTabView: View {

	@ObservedObject
	var model: ServiceViewModel

	@AppStorage("selectedTab")
	private var selectedTab: Int = 0

	var body: some View {
		TabView(selection: $selectedTab) {
			// MARK: - Support status
			SystemView(model: model)
				.alert("alert-networkIssue", isPresented: $model.showingAlert) {
					Button("alert-buttonCancel") {}
					AsyncAlertButton(asyncTask: model.fetchSupport)
				} message: { model.alertMessageReason }
				.tabItem { NavigationItem.support.label }
				.tag(0)

			// MARK: - Developer status
			DeveloperList(model: model)
				.alert("alert-networkIssue", isPresented: $model.showingAlert) {
					Button("alert-buttonCancel") {}
					AsyncAlertButton(asyncTask: model.fetchDeveloper)
				} message: { model.alertMessageReason }
				.tabItem { NavigationItem.developer.label }
				.tag(1)

			// MARK: - Setting
			SettingsView(model: model, contacts: TestFlightContact())
				.tabItem { NavigationItem.settings.label }
				.tag(2)
		}
	}
}

struct TabView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceViewModel()

		var body: some View {
			NavigationTabView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
