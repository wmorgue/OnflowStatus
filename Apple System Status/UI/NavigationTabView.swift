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
					Label("Support", systemImage: "gear.badge.checkmark")
				}
				.tag(0)

			// MARK: - Developer status
			DeveloperListView(model: model)
				.tabItem {
					Label("Developer", systemImage: "hammer.circle")
				}
				.tag(1)

			// MARK: - Setting
			Text("Settings")
				.tabItem {
					Label("Settings", systemImage: "gear.circle")
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
