//
//  StandardSetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

class StandardSetGame: ObservableObject {
    typealias SetGameError = SetGame.SetGameError
    
    @Published var setGame: SetGame = SetGame()
    
    var pile: [SetGame.Card] { setGame.pile }
    
    func addExtraCards() { setGame.addExtraCards() }
    
    func toggleCardSelection(cardId: Int) {
        do {
            try setGame.toggleCardSelection(id: cardId)
        } catch SetGameError.noSuchId(let id) {
            print("There is no card with id: \(id)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
