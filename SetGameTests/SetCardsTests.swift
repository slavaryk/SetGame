//
//  SetCardsTests.swift
//  SetCardsTests
//
//  Created by Slava Rykov on 01.05.2023.
//

import XCTest
@testable import SetGame

final class SetCardsTests: XCTestCase {
    
    private var setGame: SetGame? = SetGame()

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.setGame = SetGame()
        setGame?.setupCards()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.setGame = nil
    }
    
    private func makeHashStringForCardTriplet(_ triplet: SetGame.Triplet, _ first: String, _ second: String, _ third: String) -> String {
        var hashString = ""
        
        switch triplet {
        case .first: hashString.append(first)
        case .second: hashString.append(second)
        case .third: hashString.append(third)
        }
        
        return hashString
    }

    func testCardsCount() throws {
        XCTAssertEqual(setGame?.cards.count, 81, "Cards count should be 81")
    }
    
    func testCardsUniqueness() throws {
        var hashSet: Set<String> = Set()
        
        for card in setGame!.cards {
            var cardHash = ""
            
            cardHash.append(makeHashStringForCardTriplet(card.shape, "r", "t", "o"))
            cardHash.append(makeHashStringForCardTriplet(card.shading, "f", "s", "t"))
            cardHash.append(makeHashStringForCardTriplet(card.color, "re", "g", "v"))
            
            switch card.quantity {
            case .one: cardHash.append("1")
            case .two: cardHash.append("2")
            case .three: cardHash.append("3")
            }
            hashSet.insert(cardHash)
        }
        
        XCTAssertEqual(hashSet.count, 81, "Cards must be unique")
    }

    func testPerformance() throws {
        self.measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric()
            ]
        ) {
            setGame?.setupCards()
        }
    }

}
