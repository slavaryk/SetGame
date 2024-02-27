//
//  CheckIfCardsInSetTests.swift
//  SetGameTests
//
//  Created by Slava Rykov on 21.02.2024.
//

import XCTest
@testable import SetGame

final class CheckIfCardsInSetTests: XCTestCase {
    
    private var setGame: SetGame? = SetGame()
    
    private var testableCards: [SetGame.Card] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        buildThreeCardsWithSameTriplets()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        setGame = nil
        testableCards = []
    }
    
    private func buildThreeCardsWithSameTriplets() {
        var idCounter = 1
        
        for _ in 0..<3 {
            testableCards.append(SetGame.Card(
                id: idCounter,
                shape: SetGame.Triplet.first,
                shading: SetGame.Triplet.first,
                color: SetGame.Triplet.first,
                quantity: SetGame.Triplet.first
            ))

			idCounter += 1
        }
    }
    
    private func replaceCardInTestableCards(with card: SetGame.Card, at index: Int) {
        guard index < testableCards.count else { return }
        testableCards[index] = card
    }

    func testInSetCards() throws {
        let result = setGame?.checkIfCardsInSet(testableCards)
        XCTAssertEqual(result, true, "Should return true if cards in set")
    }
    
    func testNotInSetCards() throws {
        replaceCardInTestableCards(with: SetGame.Card(
            id: testableCards.count + 1,
            shape: SetGame.Triplet.second,
            shading: SetGame.Triplet.second,
            color: SetGame.Triplet.third,
            quantity: SetGame.Triplet.third
        ), at: 1)
        
        let result = setGame?.checkIfCardsInSet(testableCards)
        
        XCTAssertEqual(result, false, "Should return false if cards are not in set")
    }

}
