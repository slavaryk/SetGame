//
//  StandardSetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

class StandardSetGame: ObservableObject {
    @Published var setGame: SetGame = SetGame()
    
    var pile: [SetGame.Card] { setGame.pile }
}
