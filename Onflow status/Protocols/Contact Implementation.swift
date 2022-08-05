//
//  Contact Implementation.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/1/22.
//

import Foundation

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
