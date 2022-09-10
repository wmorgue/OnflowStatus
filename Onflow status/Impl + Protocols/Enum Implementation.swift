//
//  Enum Implementation.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/17/22.
//

import Foundation

enum EventStatusMessage {
	case support
	case developer

	var text: String {
		switch self {
		case .support: return "resolved"
		case .developer: return "resolved" // before: completed
		}
	}
}

enum AppIcon: CaseIterable {
	case dark
	case light

	var iconName: String? {
		switch self {
		case .dark: return nil
		case .light: return "LightIcon"
		}
	}
}
