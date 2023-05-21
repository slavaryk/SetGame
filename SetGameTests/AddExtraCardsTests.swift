//
//  AddExtraCardsTests.swift
//  SetGameTests
//
//  Created by Slava Rykov on 14.05.2023.
//

import XCTest
@testable import SetGame

final class AddExtraCardsTests: XCTestCase {
    
    private var setGame: SetGame? = SetGame()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        setGame = nil
    }

    func testAddition() throws {
        setGame?.addExtraCards()
        XCTAssertEqual(setGame?.pileSize, 15, "PlayingDeck property value should be 15 after extra cards addition")
    }
    
    func testAdditionWithFullDeck() throws {
        let additionIterationsCount = ceil(Double(setGame!.freeCards.count) / Double(3))
        for _ in 1...Int(additionIterationsCount) {
            setGame?.addExtraCards()
        }
        XCTAssertEqual(setGame?.pileSize, setGame?.pile.count, "Pile property value shouldn't grow if playing deck is full")
    }
}
