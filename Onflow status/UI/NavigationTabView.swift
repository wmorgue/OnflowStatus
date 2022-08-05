//
//  NavigationTabView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import OnflowNetwork
import SwiftUI

struct NavigationTabView: View {

	// В рут уровень передаем 2 сервиса

	@StateObject
	private var systemStatus: SystemStatusViewModel

	@StateObject
	private var developerStatus: DeveloperStatusViewModel

	init(systemService: OnflowServiceProtocol, developerService: OnflowServiceProtocol) {
		_systemStatus = StateObject(wrappedValue: SystemStatusViewModel(onflowService: systemService))
		_developerStatus = StateObject(wrappedValue: DeveloperStatusViewModel(onflowService: developerService))
	}

	@AppStorage("selectedTab")
	private var selectedTab: Int = 0

	var body: some View {
		TabView(selection: $selectedTab) {
			// MARK: - Support status
			SystemView(model: systemStatus)
				.alert("alert-networkIssue", isPresented: $systemStatus.showingAlert) {
					Button("alert-buttonCancel") {}
					AsyncAlertButton(asyncTask: systemStatus.fetchServices)
				} message: { systemStatus.alertMessageReason }
				.tabItem { NavigationItem.support.label }
				.tag(0)

			// MARK: - Developer status
			DeveloperView(model: developerStatus)
				.alert("alert-networkIssue", isPresented: $developerStatus.showingAlert) {
					Button("alert-buttonCancel") {}
					AsyncAlertButton(asyncTask: developerStatus.fetchServices)
				} message: { developerStatus.alertMessageReason }
				.tabItem { NavigationItem.developer.label }
				.tag(1)

			// MARK: - Setting
			SettingsView(model: systemStatus)
				.tabItem { NavigationItem.settings.label }
				.tag(2)
		}
		.task {
			await systemStatus.fetchServices()
			await developerStatus.fetchServices()
		}
	}
}

struct TabView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationTabView(
			systemService: SystemStatusService(),
			developerService: DeveloperStatusService()
		)
	}
}
