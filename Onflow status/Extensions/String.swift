//
//  StringExtension.swift
//  Onflow status
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

	// Remove white spaces and \n
	var trim: String { trimmingCharacters(in: .whitespacesAndNewlines) }

	static var bundleIdentifier: String {
		Bundle.main.bundleIdentifier ?? "ca.rossik.onflow-status"
	}

	static func relativeStartDate(from startDate: String, localeUS: String = "en_US") -> String {
		let strategy = Date.ParseStrategy(format: "\(month: .twoDigits)/\(day: .twoDigits)/\(year: .defaultDigits) \(hour: .twoDigits(clock: .twelveHour, hourCycle: .zeroBased)):\(minute: .twoDigits) PDT", locale: Locale(identifier: localeUS), timeZone: .current)
		guard let date = try? Date(startDate, strategy: strategy) else { return Date.now.formatted() }

		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full

		return formatter.localizedString(for: date, relativeTo: .now)
	}
}
