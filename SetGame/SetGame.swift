//
//  SetGame.swift
//  SetGame
//
//  Created by Slava Rykov on 01.05.2023.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card] = []
    
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
    }
    
    struct Card: Identifiable {
        let id: Int
        let shape: Triplet
        let shading: Triplet
        let color: Triplet
        let quantity: Quantity
    }
    
    enum Triplet: CaseIterable {
        case first, second, third
    }
    
    enum Quantity: Int, CaseIterable {
        case one = 1, two = 2, three = 3
    }
}
