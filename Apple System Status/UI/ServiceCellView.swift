//
//  ServiceCellView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceCellView: View {

	let service: Services

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
				.foregroundColor(.green)
		}
	}
}

struct ServiceCellView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceCellView(MockData.servicesJSON.first!)
	}
}
