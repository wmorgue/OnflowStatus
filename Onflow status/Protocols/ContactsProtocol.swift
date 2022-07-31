//
//  ContactsProtocol.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/31/22.
//

import Foundation

/// Contains contacts links
protocol ContactsProtocol {
	/// E-mail to me
	var mail: URL { get }

	/// Telegram link to me
	var telegram: URL { get }

	/// Link to App Store (if the link exists)
	var appStore: URL { get }

	/// Link to TestFlight
	var testFlight: URL { get }
}
