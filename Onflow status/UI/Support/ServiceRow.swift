//
//  ServiceRow.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceRow: View {

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

struct ServiceCellView_Previews: PreviewProvider {
	static var previews: some View {
		let previewService = Services(serviceName: "Активация устройств с iOS", events: [])
		ServiceRow(previewService)
	}
}
