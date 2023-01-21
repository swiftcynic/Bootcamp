//
//  globalVariables.swift
//  Bootcamp
//
//  Created by Dhruv Salot on 21/01/23.
//

import Foundation
import SwiftUI

public var backGround: some View {
    RadialGradient(
        gradient:Gradient(colors: [Color(#colorLiteral(red: 0.5134466887, green: 0.1860841811, blue: 0.8964890242, alpha: 1)), Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1))]),
        center: .topLeading,
        startRadius: 10,
        endRadius: 900)
        .ignoresSafeArea()
}

public enum Gender: String {
    case male = "male"
    case female = "female"
    case others = "others"
}
