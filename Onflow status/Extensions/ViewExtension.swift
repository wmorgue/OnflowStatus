//
//  ViewExtension.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/7/22.
//

import SwiftUI

extension View {
	func playSuccessHaptic() {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(.success)
	}
}
