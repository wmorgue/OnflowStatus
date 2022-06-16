//
//  ServiceListView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceListView: View {
	let services: [Services]

	var body: some View {
		NavigationStack {
			List(services) { service in
				NavigationLink(destination: Text(service.serviceName)) {
					ServiceCellView(service)
				}
			}
//						.navigationDestination(for: Services.self) { s in
//								Text("Detail: \(s)")
//						}
			.navigationTitle("Support")
		}
	}
}

struct StatusListView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceListView(services: MockData.servicesJSON)
	}
}
