//
//  DeveloperRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import OnflowNetwork
import OSLog
import SwiftUI

struct DeveloperRow: View {

	var service: Services

	init(_ service: Services) {
		self.service = service
	}

	@Environment(\.openURL)
	private var openURL

	fileprivate func openUnwrapURL() {
		if let link = service.redirectUrl {
			// sometimes links have a whitespace and you can't open a link.
			if let url = URL(string: link.trim) {
				#if targetEnvironment(simulator)
					Logger().info("✅ Developer Row | \(#function): \(url)")
				#endif
				openURL(url)
			}
		}
	}

	var body: some View {
		HStack {
			Image(systemName: "circle.dotted")
				.foregroundColor(.setCircleColor(service, message: .developer))
			Label(service.serviceName, systemImage: "link")
				.foregroundColor(service.events.isEmpty ? .primary : .blue)
				.lineLimit(1)
				.labelStyle(AdaptiveLabel(redirectUrl: service.redirectUrl))
		}
		.contextMenu {
			if service.redirectUrl != nil {
				Button {
					openUnwrapURL()
				} label: {
					Label("Open website", systemImage: "globe")
				}
			}

//			if let website = service.redirectUrl {
//				ShareLink(item: website, subject: Text("Onflow status")) {
//					Label("Share the website", systemImage: "square.and.arrow.up")
//				}
//			}
		}
	}
}

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
		let previewMock = Services(serviceName: "Xcode Cloud", redirectUrl: "https://developer.apple.com/xcode-cloud/", events: [])
		DeveloperRow(previewMock)
	}
}
