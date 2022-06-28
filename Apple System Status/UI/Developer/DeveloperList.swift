//
//  DeveloperList.swift
//  Apple System Status
//
//  Created by Nikita Rossik on 6/22/22.
//

import SwiftUI

struct DeveloperList: View {
	@ObservedObject
	var model: ServiceListModel

	var body: some View {
		NavigationStack {
			List(model.developers) { dev in
				DeveloperRow(service: dev)
			}
			.task { await model.fetchDeveloper() }
			.refreshable { await model.fetchDeveloper() }
			.navigationTitle("Developer")
		}
	}
}

struct DeveloperList_Previews: PreviewProvider {
	struct Preview: View {
		@StateObject
		private var model = ServiceListModel.preview

		var body: some View {
			ServiceListView(model: model)
		}
	}

	static var previews: some View {
		Preview()
	}
}
