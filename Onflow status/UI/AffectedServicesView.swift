//
//  AffectedServicesView.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/17/22.
//

import SwiftUI

struct AffectedServicesView: View {

	let affected: [Event]

	var body: some View {
		Grid {
			ForEach(affected) { affect in
				ForEach(affect.affectedServices!, id: \.self) { service in
					GridRow {
						Button {
							// action
						} label: {
							Text(service)
						}
						.tint(Color.indigo)
						.buttonStyle(.borderedProminent)
					}
				}
			}
		}
	}
}

struct AffectedServicesView_Previews: PreviewProvider {
	static var previews: some View {
		AffectedServicesView(affected: MockData.events)
	}
}
