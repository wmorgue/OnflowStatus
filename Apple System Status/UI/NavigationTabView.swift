//
//  NavigationTabView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct NavigationTabView: View {

	@ObservedObject
	var model: ServiceListModel

	@AppStorage("selectedTab")
	private var selectedTab: Int = 0

	var body: some View {
		TabView(selection: $selectedTab) {
			// MARK: - Support status
			ServiceListView(model: model)
				.tabItem {
					Label("Support", systemImage: "rectangle.stack")
				}
				.tag(0)

			// MARK: - Developer status
			DeveloperList(model: model)
				.tabItem {
					Label("Developer", systemImage: "hammer")
				}
				.tag(1)

			// MARK: - Setting
			SettingsView()
				.tabItem {
					Label("Settings", systemImage: "gear")
				}
				.tag(2)
		}
	}
}

struct TabView_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceListModel()

		var body: some View {
			NavigationTabView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
