//
//  CheckEqualityTests.swift
//  SetGameTests
//
//  Created by Slava Rykov on 27.02.2024.
//

import XCTest
@testable import SetGame

final class CheckEqualityTests: XCTestCase {
	private var setGame: SetGame? = SetGame()
	
	private var testableCards: [SetGame.Card] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
		try super.tearDownWithError()
		setGame = nil
		testableCards = []
    }

	private func buildThreeCardsWithEqualParameters() {
		let value = SetGame.Triplet.first

		testableCards.append(SetGame.Card(id: 1, shape: value, shading: value, color: value, quantity: value))
		testableCards.append(SetGame.Card(id: 2, shape: value, shading: value, color: value, quantity: value))
		testableCards.append(SetGame.Card(id: 3, shape: value, shading: value, color: value, quantity: value))
	}

	private func buildThreeCardsWithUnequalParameters() {
		testableCards.append(SetGame.Card(id: 1, shape: SetGame.Triplet.first, shading: SetGame.Triplet.first, color: SetGame.Triplet.first, quantity: SetGame.Triplet.first))
		testableCards.append(SetGame.Card(id: 2, shape: SetGame.Triplet.second, shading: SetGame.Triplet.second, color: SetGame.Triplet.second, quantity: SetGame.Triplet.second))
		testableCards.append(SetGame.Card(id: 3, shape: SetGame.Triplet.third, shading: SetGame.Triplet.third, color: SetGame.Triplet.third, quantity: SetGame.Triplet.third))
	}

	private func buildThreeCardsWithDifferentParameters() {
		testableCards.append(SetGame.Card(id: 1, shape: SetGame.Triplet.first, shading: SetGame.Triplet.first, color: SetGame.Triplet.first, quantity: SetGame.Triplet.third))
		testableCards.append(SetGame.Card(id: 2, shape: SetGame.Triplet.first, shading: SetGame.Triplet.second, color: SetGame.Triplet.second, quantity: SetGame.Triplet.third))
		testableCards.append(SetGame.Card(id: 3, shape: SetGame.Triplet.first, shading: SetGame.Triplet.third, color: SetGame.Triplet.third, quantity: SetGame.Triplet.third))
	}

    func testEqualParameters() throws {
		buildThreeCardsWithEqualParameters()
		
		var result = true

		for key in ["shape", "shading", "color", "quantity"] {
			result = setGame?.checkEqualityOf(testableCards, for: key) ?? false
		}

		XCTAssertEqual(result, true)
    }

	func testUnequalParameters() throws {
		buildThreeCardsWithUnequalParameters()

		var result = false

		for key in ["shape", "shading", "color", "quantity"] {
			result = setGame?.checkEqualityOf(testableCards, for: key) ?? true
		}

		XCTAssertEqual(result, false)
	}

	func testCardsWithSomeEqualAndSomeUnequalParameters() {
		buildThreeCardsWithDifferentParameters()

		var result: [Bool] = []

		for key in ["shape", "shading", "color", "quantity"] {
			result.append(setGame?.checkEqualityOf(testableCards, for: key) ?? false)
		}

		XCTAssertEqual(result, [true, false, false, true])
	}
}
