//
//  SortListButton.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/10/22.
//

import SwiftUI

struct SortListButton: View {

	@Binding
	var toggleButton: Bool
	let isDisabledReason: ClosureBool

	var body: some View {
		Button {
			toggleButton.toggle()
		} label: {
			Image(systemName: "arrow.up.arrow.down.square")
				.foregroundStyle(Color.sortEventsButton)
				.symbolRenderingMode(.hierarchical)
		}
		.disabled(isDisabledReason())
	}
}

struct SortListButton_Previews: PreviewProvider {
	static var previews: some View {
		SortListButton(toggleButton: .constant(false)) { false }
	}
}
