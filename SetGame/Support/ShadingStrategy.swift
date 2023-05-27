//
//  ShadingStrategy.swift
//  SetGame
//
//  Created by Slava Rykov on 25.05.2023.
//

import SwiftUI

protocol ShadingStrategy {
    func getShadingOpacity() -> CGFloat
}

struct FilledShading: ShadingStrategy {
    func getShadingOpacity() -> CGFloat {
        CGFloat(1.0)
    }
}

struct TranslucentShading: ShadingStrategy {
    func getShadingOpacity() -> CGFloat {
        CGFloat(0.3)
    }
}

struct ClearShading: ShadingStrategy {
    func getShadingOpacity() -> CGFloat {
        CGFloat(0.0)
    }
}
