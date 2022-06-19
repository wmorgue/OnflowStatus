//
//  Apple_System_StatusApp.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

@main
struct Apple_System_StatusApp: App {

	@StateObject
	var model = ServiceListModel()

	var body: some Scene {
		WindowGroup {
			NavigationTabView(model: model)
		}
	}
}
