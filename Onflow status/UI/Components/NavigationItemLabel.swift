//
//  NavigationItemLabel.swift
//  Onflow status
//
//  Created by Nikita Rossik on 8/4/22.
//

import SwiftUI

enum NavigationItem {
	case support
	case developer
	case settings

	static let systemTitle = String(localized: "navigation-systemTitle")
	static let developerTitle = String(localized: "navigation-developerTitle")
	static let settingsTitle = String(localized: "navigation-settingsTitle")

	var label: some View {
		switch self {
		case .support: return Label(Self.systemTitle, systemImage: "rectangle.stack")
		case .developer: return Label(Self.developerTitle, systemImage: "hammer")
		case .settings: return Label(Self.settingsTitle, systemImage: "gear")
		}
	}
}
