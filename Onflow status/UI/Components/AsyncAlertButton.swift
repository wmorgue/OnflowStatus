//
//  AsyncAlertButton.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/7/22.
//

import SwiftUI

struct AsyncAlertButton: View {

	let asyncTask: ClosureAsyncAction

	var body: some View {
		Button(role: .cancel) {
			Task {
				await asyncTask()
			}
		} label: {
			Text("asyncAlertButtonText")
		}
	}
}

struct ButtonExtension_Previews: PreviewProvider {
	static var previews: some View {
		AsyncAlertButton {}
	}
}
