//
//  DeveloperRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

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
					.foregroundColor(setCircleColor)

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

extension DeveloperRow {
	var setCircleColor: Color {
		service
			.events
			.map(\.eventStatus)
			.contains("completed") || service.events.isEmpty ? .green : .orange
	}

//	var dynamicLable: some View {
//		Label(service.serviceName, systemImage: "link")
//			.foregroundColor(.primary)
//			.lineLimit(1)
//			.minimumScaleFactor(0.9)
//			.labelStyle(service.redirectUrl == .none ? .titleOnly : .iconOnly)
//	}
}

// fileprivate struct DeveloperTextRow: View {
//
//	var service: Services
//
//	@Environment(\.openURL) private var openURL
//
//	init(_ service: Services) {
//		self.service = service
//	}
//
//	fileprivate func openUnwrapURL() {
//		if let link = service.redirectUrl {
//			// sometimes links have a whitespace and you can't open a link.
//			if let url = URL(string: link.trim) {
//				openURL(url)
//			}
//		}
//	}
//
//	var body: some View {
//		Label {
//			switch service.redirectUrl == nil {
//			case true:
//				Text(service.serviceName)
//			case false:
//				Label(service.serviceName, systemImage: "link")
//					.labelStyle(.reversed)
//			}
//		} icon: {
//			Image(systemName: "circle.dotted")
//				.foregroundColor(setCircleColor)
//		}
//		.lineLimit(1)
//		.minimumScaleFactor(0.8)
//		.onTapGesture { openUnwrapURL() }
//	}
// }
//
// extension DeveloperTextRow {
//	var setCircleColor: Color {
//		service
//			.events
//			.map(\.eventStatus)
//			.contains("completed") || service.events.isEmpty ? .green : .orange
//	}
// }

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
		DeveloperRow(service: MockData.developerService)
	}
}
