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

	var label: some View {
		switch self {
		case .support: return Label("Support", systemImage: "rectangle.stack")
		case .developer: return Label("Developer", systemImage: "hammer")
		case .settings: return Label("Settings", systemImage: "gear")
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
			SupportView(model: model)
				.alert("Network issue", isPresented: $model.showingAlert,
				       actions: {
				       	Button("Cancel", role: .cancel) {}
				       	AsyncAlertButton(asyncTask: model.fetchSupport)
				       },
				       message: { model.alertMessageReason })
				.tabItem { NavigationItem.support.label }
				.tag(0)

			// MARK: - Developer status
			DeveloperList(model: model)
				.alert("Network issue", isPresented: $model.showingAlert,
				       actions: {
				       	Button("Cancel", role: .cancel) {}
				       	AsyncAlertButton(asyncTask: model.fetchDeveloper)
				       },
				       message: { model.alertMessageReason })
				.tabItem { NavigationItem.developer.label }
				.tag(1)

			// MARK: - Setting
			SettingsView(model: model)
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
