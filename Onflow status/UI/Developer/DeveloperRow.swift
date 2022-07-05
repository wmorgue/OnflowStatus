//
//  DeveloperRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

fileprivate struct DeveloperTextRow: View {

	var service: Services

	@Environment(\.openURL) private var openURL

	init(_ service: Services) {
		self.service = service
	}

	fileprivate func openUnwrapURL() {
		if let link = service.redirectUrl {
			// sometimes links have a whitespace and you can't open a link.
			if let url = URL(string: link.trim) {
				openURL(url)
			}
		}
	}

	var body: some View {
		Label {
			switch service.redirectUrl == nil {
			case true:
				Text(service.serviceName)
			case false:
				Label(service.serviceName, systemImage: "link")
					.labelStyle(.reversed)
			}
		} icon: {
			Image(systemName: "circle.dotted")
				.foregroundColor(setCircleColor)
		}
		.foregroundColor(service.events.isEmpty ? .primary : .blue)
		.lineLimit(1)
		.minimumScaleFactor(0.8)
		.onTapGesture(count: 2) {
			openUnwrapURL()
		}
	}
}

extension DeveloperTextRow {
	var setCircleColor: Color {
		service
			.events
			.map(\.eventStatus)
			.contains("completed") || service.events.isEmpty ? .green : .orange
	}
}

struct DeveloperRow: View {

	var service: Services

	var body: some View {
		DeveloperTextRow(service)
	}
}

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
		DeveloperTextRow(MockData.developerService)
	}
}
