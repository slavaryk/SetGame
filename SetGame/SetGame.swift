//
//  SetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 01.05.2023.
//

struct SetGame {
    private static let MIN_PILE_SIZE_BEFORE_EMPTINESS = 12
    private static let EXTRA_CARDS_GROWTH = 3
    
    private(set) var pileSize: Int = SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS
    private(set) var cards: [Card] = []

	var freeCards: [Card] { cards.filter { !$0.isInSet } }

    var selectedCards: [Card] { freeCards.filter { $0.isSelected } }

    var pile: [Card] { Array(freeCards[0..<pileSize]) }
    
    init() {
        setupCards()
    }
    
    mutating func setupCards() {
        var idCounter = 1
        
        for shape in Triplet.allCases {
            for shading in Triplet.allCases {
                for color in Triplet.allCases {
                    for quantity in Triplet.allCases {
                        cards.append(Card(id: idCounter, shape: shape, shading: shading, color: color, quantity: quantity))
                        idCounter += 1
                    }
                    idCounter += 1
                }
                idCounter += 1
            }
            idCounter += 1
        }
        
        cards.shuffle()
    }
    
    mutating func toggleCardSelection(id: Int) throws {
        guard let cardIndex = cards.firstIndex(where: { $0.id == id }) else { throw SetGameError.noSuchId(id: id) }
        cards[cardIndex].isSelected = !cards[cardIndex].isSelected
    }
    
    mutating func addExtraCards() {
        let remainingCards = freeCards.count - pileSize
        
        if remainingCards >= SetGame.EXTRA_CARDS_GROWTH {
            pileSize += SetGame.EXTRA_CARDS_GROWTH
        } else {
            pileSize += remainingCards
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

	func checkInequalityOf(_ cardList: [Card], for key: String) -> Bool {
		var isUnequal = false

		for card in cardList {
			isUnequal = cardList.allSatisfy {
				card.id == $0.id ? true : card[triplet: key] != $0[triplet: key]
			}
		}

		return isUnequal
	}

	mutating func markAsSetAndUnselect(_ cardList: [Card]) {
		for card in cardList {
			let cardIndex = cards.firstIndex(where: { $0.id == card.id })

			cards[cardIndex!].isInSet = true
			cards[cardIndex!].isSelected = false
		}
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
    enum Triplet: CaseIterable {
        case first, second, third
    }
    
    enum SetGameError: Error {
        case noSuchId(id: Int)
		case invalidAmountOfCards
    }
}
