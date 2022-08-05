//
//  SystemRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import OnflowNetwork
import SwiftUI

struct SystemRow: View {

	var service: Services

	init(_ service: Services) {
		self.service = service
	}

	var body: some View {
		Label {
			Text(service.serviceName)
				.lineLimit(1)
				.foregroundColor(service.events.isEmpty ? .primary : .blue)
		} icon: {
			Image(systemName: "circle.dotted")
				.foregroundColor(.setCircleColor(service, message: .support))
		}
	}
}

struct SystemRow_Previews: PreviewProvider {

	static var previews: some View {

		let previewMock = Services(serviceName: "Активация устройств с iOS", events: [])
		SystemRow(previewMock)
	}
}
