//
//  RemoveExtraCardsTests.swift
//  SetGameTests
//
//  Created by Slava Rykov on 10.03.2024.
//

import XCTest
@testable import SetGame

final class RemoveExtraCardsTests: XCTestCase {
	private var setGame: SetGame? = SetGame()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
		setGame = nil
    }

    func testSubtraction() throws {
		setGame?.addExtraCards()
		setGame?.addExtraCards()

		setGame?.removeExtraCardsIfNeeded()

		XCTAssertEqual(setGame?.pileSize, SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS + SetGame.EXTRA_CARDS_DELTA)
    }

	func testSubtractionWhenMinimumReached() throws {
		setGame?.removeExtraCardsIfNeeded()
		XCTAssertEqual(setGame?.pileSize, SetGame.MIN_PILE_SIZE_BEFORE_EMPTINESS)
	}
}
