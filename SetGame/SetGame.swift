//
//  SetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 01.05.2023.
//

struct SetGame {
	static let MIN_PILE_SIZE_BEFORE_EMPTINESS = 12
	static let EXTRA_CARDS_DELTA = 3

    private(set) var pileSize: Int = SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS
    private(set) var cards: [Card] = []

	var freeCards: [Card] { cards.filter { !$0.isInSet } }

    var selectedCards: [Card] { freeCards.filter { $0.isSelected } }

	var pile: [Card] {
		if (pileSize <= freeCards.count) {
			return Array(freeCards[0..<pileSize])
		} else {
			return freeCards
		}
	}

	mutating func setCards(cards: [Card]) {
		self.cards = cards
	}

    mutating func toggleCardSelection(id: Int) throws {
        guard let cardIndex = cards.firstIndex(where: { $0.id == id }) else { throw SetGameError.noSuchId(id: id) }
        cards[cardIndex].isSelected = !cards[cardIndex].isSelected
    }

    mutating func addExtraCards() {
        let remainingCards = freeCards.count - pileSize
		pileSize += min(remainingCards, SetGame.EXTRA_CARDS_DELTA)
    }

	mutating func removeExtraCardsIfNeeded() {
		let newSize = pileSize - SetGame.EXTRA_CARDS_DELTA
		pileSize = max(newSize, SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS)
	}

	/**
	 TODO:
	1) Write tests []
	 */
	mutating func markAsSetAndUnselect(_ cardList: [Card]) {
		for card in cardList {
			let cardIndex = cards.firstIndex(where: { $0.id == card.id })

			cards[cardIndex!].isInSet = true
			cards[cardIndex!].isSelected = false
		}
	}

    func checkIfCardsInSet(_ cardList: [Card]) -> Bool {
		return checkForEqualityOrInequalityOf(cardList, for: "shape")
			&& checkForEqualityOrInequalityOf(cardList, for: "shading")
			&& checkForEqualityOrInequalityOf(cardList, for: "color")
			&& checkForEqualityOrInequalityOf(cardList, for: "quantity")
    }

	func checkForEqualityOrInequalityOf(_ cardList: [Card], for key: String) -> Bool {
		let isCheckingEquality = cardList.first?[triplet: key] == cardList.last?[triplet: key]

		return isCheckingEquality ?
			checkEqualityOf(cardList, for: key)
			: checkInequalityOf(cardList, for: key)
	}

	func checkEqualityOf(_ cardList: [Card], for key: String) -> Bool {
		var isEqual = false
		var lastValue: Triplet?

		for card in cardList {
			let value = card[triplet: key]

			isEqual = lastValue == value
			lastValue = value
		}

		return isEqual
	}

	/**
	 TODO:
	 1) Write tests []
	 */
	func checkInequalityOf(_ cardList: [Card], for key: String) -> Bool {
		let cardListTriplets = cardList.map {
			$0[triplet: key]
		}

		return Set(cardListTriplets).count == 3
	}

    struct Card: Identifiable, Equatable {
        let id: Int
        let shape: Triplet
        let shading: Triplet
        let color: Triplet
        let quantity: Triplet
        var isSelected = false
        var isInSet = false

		subscript(triplet key: String) -> Triplet? {
			switch key {
			case "shape": return self.shape
			case "shading": return self.shading
			case "color": return self.color
			case "quantity": return self.quantity
			default: return nil
			}
		}
    }

    enum Triplet: CaseIterable, Codable {
        case first, second, third

		func toString() -> String {
			switch self {
			case .first: return "first"
			case .second: return "second"
			case .third: return "third"
			}
		}

		func toInt() -> Int16 {
			switch self {
			case .first: return Int16(1)
			case .second: return Int16(2)
			case .third: return Int16(3)
			}
		}

		static func fromString(_ value: String) -> Triplet {
			switch value {
			case "first": return Triplet.first
			case "second": return Triplet.second
			case "third": return Triplet.third
			default: return Triplet.first
			}
		}

		static func fromInt(_ value: Int) -> Triplet {
			switch value {
			case 1: return Triplet.first
			case 2: return Triplet.second
			case 3: return Triplet.third
			default: return Triplet.first
			}
		}
    }
    
    enum SetGameError: Error {
        case noSuchId(id: Int)
    }
}
