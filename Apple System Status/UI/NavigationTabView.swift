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

	var body: some View {
		TabView {
			// MARK: - Support status

			ServiceListView(model: model)
				.tabItem {
					Label("Support", systemImage: "gear.badge.checkmark")
				}

			// MARK: - Developer status

			Text("Developer status")
				.tabItem {
					Label("Developer", systemImage: "hammer.circle")
				}

			// MARK: - Setting

			Text("Settings")
				.tabItem {
					Label("Settings", systemImage: "gear.circle")
				}
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
