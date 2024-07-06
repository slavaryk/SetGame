//
//  StandardSetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

class StandardSetGame: ObservableObject {
    typealias SetGameError = SetGame.SetGameError

	static let LENGTH_TO_CHECK_CARDS = 3

    @Published var setGame: SetGame = SetGame()
    
    var pile: [SetGame.Card] { setGame.pile }
	var selectedCards: [SetGame.Card] { setGame.selectedCards }

	func addExtraCards() {
		setGame.addExtraCards()
	}

	func removeExtraCardsIfNeeded() {
		setGame.removeExtraCardsIfNeeded()
	}

	func checkIfCardsInSet() -> Bool {
		setGame.checkIfCardsInSet(selectedCards)
	}

    func toggleCardSelection(cardId: Int) {
        do {
            try setGame.toggleCardSelection(id: cardId)
        } catch SetGameError.noSuchId(let id) {
            print("There is no card with id: \(id)")
        } catch {
            print("Unexpected error: \(error)")
        }

		if selectedCards.count == StandardSetGame.LENGTH_TO_CHECK_CARDS {
			checkSelectedCards()
		}
    }

	func checkSelectedCards() {
		if checkIfCardsInSet() {
			markSelectedCardsAsInSetAndUnselectThem()
			removeExtraCardsIfNeeded()
		} else {
			selectedCards.forEach { card in
				toggleCardSelection(cardId: card.id)
			}
		}
	}

	func markSelectedCardsAsInSetAndUnselectThem() {
		setGame.markAsSetAndUnselect(selectedCards)
	}
}
