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
    
    var selectedCards: [Card] { cards.filter { $0.isSelected } }
    
    var freeCards: [Card] { cards.filter { !$0.isInSet } }
    
    var pile: [Card] { get { Array(freeCards[0..<pileSize]) } }
    
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
    
    struct Card: Identifiable {
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
