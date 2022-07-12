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
	var model = ServiceViewModel()

	var body: some Scene {
		WindowGroup {
			NavigationTabView(model: model)
				.task {
					await model.fetchSupport()
					await model.fetchDeveloper()
				}
		}
	}
}
