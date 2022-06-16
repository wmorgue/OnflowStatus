//
//  NavigationTabView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct NavigationTabView: View {

	var body: some View {
		TabView {
			// MARK: - Support status

			Text("Support status")
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
	static var previews: some View {
		NavigationTabView()
	}
}
