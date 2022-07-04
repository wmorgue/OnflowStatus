//
//  DeveloperRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

struct DevRow: View {

	var service: Services

	init(_ service: Services) {
		self.service = service
	}

	var body: some View {
		Label {
			Text(service.serviceName)
				.lineLimit(1)
				.minimumScaleFactor(0.8)
				.foregroundColor(service.events.isEmpty ? .primary : .blue)
		} icon: {
			Image(systemName: "circle.dotted")
				.foregroundColor(service.events.isEmpty ? .green : .orange)
		}
	}
}

struct DeveloperRow: View {

	var service: Services
	@Environment(\.openURL) private var openURL

	fileprivate func openUnwrapURL() {
		if let link = service.redirectUrl {
			// sometimes links have a whitespace and you can't open a link.
			if let url = URL(string: link.trim) {
				openURL(url)
			}
		}
	}

	var body: some View {

		Button {
			openUnwrapURL()
		} label: {
			HStack {
				Image(systemName: "circle.dotted")
					.foregroundColor(service.events.isEmpty ? .green : .orange)

				Label(service.serviceName, systemImage: "link")
					.foregroundColor(service.redirectUrl != nil ? .blue : .primary)
					.lineLimit(1)
					.minimumScaleFactor(0.9)
					.labelStyle(.reversed)
			}
		}
	}
}

// try refactor later
//		Label {
//			if let link = service.redirectUrl {
//					Link(destination: URL(string: service.redirectUrl!)!) {
//					serviceName
//				}
//			} else {
//				serviceName
//			}
//		} icon: {
//			if service.redirectUrl != nil {
//				Image(systemName: "link")
//			}
//		}
//		.labelStyle(.reversed)

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
//		DevRow(MockData.developerService)
		DeveloperRow(service: MockData.developerService)
	}
}
