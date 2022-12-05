//
//  StringExtension.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/24/22.
//

import Foundation

extension String {

	// Remove white spaces and \n
	var trim: String { trimmingCharacters(in: .whitespacesAndNewlines) }

	static var bundleIdentifier: String {
		Bundle.main.bundleIdentifier ?? "ca.rossik.onflow-status"
	}
}
