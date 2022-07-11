//
//  DeveloperRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

struct DeveloperRow: View {

	var service: Services
	let circleColor: () -> Color

	init(_ service: Services, circleColor: @escaping () -> Color) {
		self.service = service
		self.circleColor = circleColor
	}

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
					.foregroundColor(circleColor())

				// ternary operator doesn't work in label style modifier
				// https://useyourloaf.com/blog/adapting-swiftui-label-style/
				if service.redirectUrl != nil {
					Label(service.serviceName, systemImage: "link")
						.foregroundColor(.primary)
						.lineLimit(1)
						.minimumScaleFactor(0.9)
						.labelStyle(.reversed)
				} else {
					Label(service.serviceName, systemImage: "link")
						.foregroundColor(.primary)
						.lineLimit(1)
						.minimumScaleFactor(0.9)
						.labelStyle(.titleOnly)
				}
			}
		}
	}
}

//	var dynamicLabel: some View {
//		Label(service.serviceName, systemImage: "link")
//			.foregroundColor(.primary)
//			.lineLimit(1)
//			.minimumScaleFactor(0.9)
//			.labelStyle(service.redirectUrl == .none ? .titleOnly : .iconOnly)
//	}

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
		DeveloperRow(MockData.developerService) { .green }
	}
}
