//
//  Onflow_StatusApp.swift
//  Onflow Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import OnflowNetwork
import SwiftUI

@main
struct OnflowStatusApp: App {

	var body: some Scene {
		WindowGroup {

			// Production services
			let systemStatusService = SystemStatusService()
			let developerStatusService = DeveloperStatusService()

			/*
			 Test mock services:

			 let mockStatusService = MockStatusService()
			 let mockDeveloperService = MockDeveloperService()
			 */

			// Dependency Injection in nutshell
			// Здесь нужно передавать SystemMockDataService & DeveloperMockDataService
			NavigationTabView(
				systemService: systemStatusService,
				developerService: developerStatusService
			)
		}
	}
}
