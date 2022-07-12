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
		Button {
			Task { await asyncTask() }
		} label: {
			Text("Try again")
		}
	}
}

struct ButtonExtension_Previews: PreviewProvider {
	static var previews: some View {
		AsyncAlertButton {}
	}
}
