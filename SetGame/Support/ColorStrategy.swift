//
//  ColorStrategy.swift
//  SetGame
//
//  Created by Slava Rykov on 27.05.2023.
//

import SwiftUI

protocol ColorStrategy: Sendable {
    func getColor() -> Color
}

struct GreenColor: ColorStrategy {
    func getColor() -> Color {
        .green
    }
}

struct BlueColor: ColorStrategy {
    func getColor() -> Color {
        .blue
    }
}

struct PinkColor: ColorStrategy {
    func getColor() -> Color {
        .pink
    }
}
