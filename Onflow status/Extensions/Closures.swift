//
//  Closures.swift
//  Onflow status
//
//  Created by Nikita Rossik on 7/11/22.
//

import Foundation
import struct SwiftUI.Color

typealias ClosureAction = () -> Void
typealias ClosureColor = () -> Color
typealias ClosureBool = () -> Bool
typealias ClosureAsyncAction = () async -> Void
