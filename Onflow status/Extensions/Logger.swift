//
//  Logger.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/31/22.
//
//
import Foundation
import OSLog

extension Logger {
	static var systemStatus: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: SystemStatusViewModel.self))
	}

	static var developerStatus: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: DeveloperStatusViewModel.self))
	}
}
