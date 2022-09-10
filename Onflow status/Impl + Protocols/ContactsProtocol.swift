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

struct TestFlightContact: ContactsProtocol {
	let mail = URL(string: "mailto:maybequantumbit@icloud.com")!
	let telegram = URL(string: "https://t.me/maybequantum")!
	let appStore = URL(string: "https://testflight.apple.com/join/XDc6ZLRZ")!
	let testFlight = URL(string: "https://testflight.apple.com/join/XDc6ZLRZ")!
}

struct ProductionContact: ContactsProtocol {
	var mail: URL = .init(string: "mailto:maybequantumbit@icloud.com")!
	var telegram: URL = .init(string: "https://t.me/maybequantum")!
	var testFlight: URL = .init(string: "https://testflight.apple.com/join/XDc6ZLRZ")!
	var appStore: URL = .init(string: "https://testflight.apple.com/join/XDc6ZLRZ")!
}
