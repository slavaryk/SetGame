//
//  ToggleCardSelectionTests.swift
//  SetGameTests
//
//  Created by Slava Rykov on 02.05.2023.
//

import XCTest
@testable import SetGame

final class ToggleCardSelectionTests: XCTestCase {
    
    private var setGame: SetGame? = SetGame()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        setGame = nil
    }

    func testThrowingWhenIdDoesntExists() throws {
        let cardId = 999
        XCTAssertThrowsError(try setGame?.toggleCardSelection(id: cardId))
    }
    
    func testCardSelection() throws {
        let cardId = 1
        let cardIndex = setGame?.cards.firstIndex { $0.id == cardId }
        try setGame?.toggleCardSelection(id: cardId)
        XCTAssertEqual(setGame?.cards[cardIndex!].isSelected, true, "Card property isSelected should be true")
    }
    
    func testCardDeselection() throws {
        let cardId = 1
        let cardIndex = setGame?.cards.firstIndex { $0.id == cardId }
        try setGame?.toggleCardSelection(id: cardId)
        try setGame?.toggleCardSelection(id: cardId)
        XCTAssertEqual(setGame?.cards[cardIndex!].isSelected, false, "Card property isSelected should be false")
    }
}
