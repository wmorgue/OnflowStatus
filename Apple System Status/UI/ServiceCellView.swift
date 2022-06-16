//
//  ServiceCellView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceCellView: View {

	let service: Services

	internal init(_ service: Services) {
		self.service = service
	}

	var body: some View {
		Label {
			Text(service.serviceName)
		} icon: {
			Image(systemName: "icloud")
				.foregroundColor(.green)
		}
	}
}

struct ServiceCellView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceCellView(MockData.servicesJSON.first!)
	}
}
