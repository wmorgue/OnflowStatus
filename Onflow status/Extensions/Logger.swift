//
//  Logger.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/31/22.
//

import Foundation
import OSLog

extension Logger {
	static var statusResource: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: NetworkLayer.self))
	}

	static var serviceModel: Logger {
		Logger(subsystem: .bundleIdentifier, category: String(describing: ServiceViewModel.self))
	}
}
