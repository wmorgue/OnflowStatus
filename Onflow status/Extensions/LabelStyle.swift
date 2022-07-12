//
//  LabelStyleExtension.swift
//  Onflow status
//
//  Created by Nikita Rossik on 6/21/22.
//

import SwiftUI

struct ReversedLabel: LabelStyle {
	/// Spacer modifier between title and icon
	var withSpacer: Bool = true

	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.title
			if withSpacer { Spacer() }
			configuration.icon
		}
	}
}

struct AdaptiveLabel: LabelStyle {
	var redirectUrl: String?

	func makeBody(configuration: Configuration) -> some View {
		// Ternary operator doesn't work
		switch redirectUrl != nil {
		case true: Label(configuration).labelStyle(.reversed)
		case false: configuration.title
		}
	}
}

extension LabelStyle where Self == ReversedLabel {
	/// A label style that show title and icon in reverse order.
	static var reversed: Self {
		ReversedLabel()
	}
}
