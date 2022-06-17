//
//  ServiceListView.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/16/22.
//

import SwiftUI

struct ServiceListView: View {
	@State private var showingSheet: Bool = false

	let services: [Services]

	var body: some View {
		NavigationStack {
			List(services) { service in
				ServiceCellView(service)
					.onTapGesture {
						guard service.events!.isEmpty else {
							showingSheet.toggle()
							return
						}
					}
					.sheet(isPresented: $showingSheet) {
							ServiceSheetView(service.serviceName, event: service.events!)
							.presentationDetents([.medium, .large])
					}
			}
			.navigationTitle("Support")
		}
	}
}

struct StatusListView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceListView(services: MockData.servicesJSON)
	}
}
