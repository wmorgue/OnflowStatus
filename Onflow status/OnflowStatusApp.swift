//
//  Onflow_StatusApp.swift
//  Onflow Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

@main
struct OnflowStatusApp: App {

	@StateObject
	var model = ServiceListModel()

	var body: some Scene {
		WindowGroup {
			NavigationTabView(model: model)
		}
	}
}
