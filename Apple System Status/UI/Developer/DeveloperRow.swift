//
//  DeveloperRow.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

struct DeveloperRow: View {

	var service: Services

	var body: some View {
		let serviceName = Text(service.serviceName)

		Label {
			if let link = service.redirectUrl {
				Link(destination: URL(string: link)!) {
					serviceName
				}
			} else {
				serviceName
			}
		} icon: {
			if service.redirectUrl != nil {
				Image(systemName: "link")
			}
		}
		.labelStyle(.reversed)
	}
}

struct DeveloperRow_Previews: PreviewProvider {
	static var previews: some View {
		DeveloperRow(service: MockData.developerService)
	}
}
