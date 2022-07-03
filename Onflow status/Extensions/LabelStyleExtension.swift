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

extension LabelStyle where Self == ReversedLabel {
	/// A label style that show title and icon in reverse order.
	static var reversed: Self {
		ReversedLabel()
	}
}
