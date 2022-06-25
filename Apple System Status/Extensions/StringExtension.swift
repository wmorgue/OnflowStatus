//
//  StringExtension.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/24/22.
//

import Foundation

extension String {
	static var affectedSeparator: (_ services: [String]) -> Self = { services in
		guard !services.isEmpty else { return "Array is empy" }

		if services.count == 2 {
			return services.joined(separator: " and ")
		} else {
			return services.joined(separator: ", ")
		}
	}
}