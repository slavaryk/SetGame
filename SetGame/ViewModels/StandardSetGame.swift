//
//  StandardSetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

class StandardSetGame: ObservableObject {
    typealias SetGameError = SetGame.SetGameError
	typealias SetGameTriplet = SetGame.Triplet
	typealias SetGameCard = SetGame.Card

	static let LENGTH_TO_CHECK_CARDS = 3

    @Published var setGame: SetGame

    var pile: [SetGameCard] { setGame.pile }
	var selectedCards: [SetGameCard] { setGame.selectedCards }

	init(isContinue: Bool) {
		if (isContinue) {
			self.setGame = SetGame()
			self.setGame.setCards(cards: buildPileOfSavedCards())
		} else {
			self.setGame = SetGame()
			self.setGame.setCards(cards: buildPileOfNewCards())
		}
	}

	func buildPileOfSavedCards() -> [SetGameCard] {
		let cards = PersistenceService.shared.getSavedCards()

		var result: [SetGameCard] = []

		for card in cards {
			result.append(SetGameCard(
				id: Int(card.id),
				shape: SetGameTriplet.fromString(card.shape ?? "first"),
				shading: SetGameTriplet.fromString(card.shade ?? "first"),
				color: SetGameTriplet.fromString(card.color ?? "first"),
				quantity: SetGameTriplet.fromInt(Int(card.quantity)),
				isInSet: card.isInSet
			))
		}

		return result
	}

	func buildPileOfNewCards() -> [SetGameCard] {
		var cards: [SetGameCard] = []
		var idCounter = 1

		PersistenceService.shared.clear()

		for shape in SetGameTriplet.allCases {
			for shading in SetGameTriplet.allCases {
				for color in SetGameTriplet.allCases {
					for quantity in SetGameTriplet.allCases {
						cards.append(SetGameCard(id: idCounter, shape: shape, shading: shading, color: color, quantity: quantity))
						idCounter += 1
					}
					idCounter += 1
				}
				idCounter += 1
			}
			idCounter += 1
		}

		cards.shuffle()
		PersistenceService.shared.saveNewCards(from: cards)

		return cards
	}

	func addExtraCards() {
		setGame.addExtraCards()
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
			PersistenceService.shared.saveCards(cardList: selectedCards, isInSet: true)

			markSelectedCardsAsInSetAndUnselectThem()
			removeExtraCardsIfNeeded()
		} else {
			selectedCards.forEach { card in
				toggleCardSelection(cardId: card.id)
			}
		}
	}

	func checkIfCardsInSet() -> Bool {
		setGame.checkIfCardsInSet(selectedCards)
	}

	func markSelectedCardsAsInSetAndUnselectThem() {
		setGame.markAsSetAndUnselect(selectedCards)
	}

	func removeExtraCardsIfNeeded() {
		setGame.removeExtraCardsIfNeeded()
	}
}
