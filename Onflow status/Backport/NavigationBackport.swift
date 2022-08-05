//
//  NavigationBackport.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/16/22.
//

import SwiftUI

// Warning: Disabled compilation
// Targets —> Onflow status —> Build Phases
public struct NavigationBackport<Content: View>: View {
	public let content: () -> Content

	public var body: some View {
		if #available(iOS 16, *) {
			return NavigationStack { content() }
		} else {
			return NavigationView { content() }
		}
	}
}

struct NavigationBackport_Previews: PreviewProvider {
	static var previews: some View {
		NavigationBackport {
			Text("Is working")
				.navigationBarTitle("Backport")
		}
	}
}
