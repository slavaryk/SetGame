//
//  SetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 01.05.2023.
//

struct SetGame {
    private static let MIN_PILE_SIZE_BEFORE_EMPTINESS = 12
    private static let EXTRA_CARDS_GROWTH = 3
    private static let LENGTH_TO_CHECK_SET = 3
    
    private(set) var pileSize: Int = SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS
    private(set) var cards: [Card] = []
    
    var selectedCards: [Card] {
        let result = cards.filter { $0.isSelected }
        
        if result.count == SetGame.LENGTH_TO_CHECK_SET {
            checkIfCardsInSet(result)
        }
        
        return result
    }
    
    var freeCards: [Card] { cards.filter { !$0.isInSet } }
    
    var pile: [Card] { Array(freeCards[0..<pileSize]) }
    
    init() {
        setupCards()
    }
    
    mutating func setupCards() {
        var idCounter = 1
        
        for shape in Triplet.allCases {
            for shading in Triplet.allCases {
                for color in Triplet.allCases {
                    for quantity in Quantity.allCases {
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
		guard cardList.count == 3 else { return false }

		/**
		 TODO:
		 1) Refactor this mess
		 */

		let MIDDLE_CARD_INDEX = 1

		var isShapeConforms = false
		var isShadingConforms = false
		var isColorConforms = false

		var isCheckingShapeEquality = false
		var isCheckingShadingEquality = false
		var isCheckingColorEquality = false

		if cardList.first?.shape == cardList.last?.shape {
			isCheckingShapeEquality = true
		}

		if cardList.first?.shading == cardList.last?.shading {
			isCheckingShadingEquality = true
		}

		if cardList.first?.color == cardList.last?.color {
			isCheckingColorEquality = true
		}

		if isCheckingShapeEquality {
			isShapeConforms = cardList[MIDDLE_CARD_INDEX].shape == cardList.first?.shape
		} else {
			isShapeConforms = cardList[MIDDLE_CARD_INDEX].shape != cardList.first?.shape
			&& cardList[MIDDLE_CARD_INDEX].shape != cardList.last?.shape
		}

		if isCheckingShadingEquality {
			isShadingConforms = cardList[MIDDLE_CARD_INDEX].shading == cardList.first?.shading
		} else {
			isShadingConforms = cardList[MIDDLE_CARD_INDEX].shading != cardList.first?.shading
			&& cardList[MIDDLE_CARD_INDEX].shading != cardList.last?.shading
		}

		if isCheckingColorEquality {
			isColorConforms = cardList[MIDDLE_CARD_INDEX].color == cardList.first?.color
		} else {
			isColorConforms = cardList[MIDDLE_CARD_INDEX].color != cardList.first?.color
			&& cardList[MIDDLE_CARD_INDEX].color != cardList.last?.color
		}

		return isShapeConforms && isShadingConforms && isColorConforms
    }
    
    struct Card: Identifiable, Equatable {
        let id: Int
        let shape: Triplet
        let shading: Triplet
        let color: Triplet
        let quantity: Quantity
        var isSelected = false
        var isInSet = false
    }
    
    enum Triplet: CaseIterable {
        case first, second, third
    }
    
    enum Quantity: Int, CaseIterable {
        case one = 1, two = 2, three = 3
    }
    
    enum SetGameError: Error {
        case noSuchId(id: Int)
    }
}
