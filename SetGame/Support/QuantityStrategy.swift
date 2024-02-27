//
//  QuantityStrategy.swift
//  SetGame
//
//  Created by Slava Rykov on 27.02.2024.
//

protocol QuantityStrategy {
	func getQuantity() -> Int
}

struct QuantityOfThree: QuantityStrategy {
	func getQuantity() -> Int {
		3
	}
}

struct QuantityOfTwo: QuantityStrategy {
	func getQuantity() -> Int {
		2
	}
}

struct QuantityOfOne: QuantityStrategy {
	func getQuantity() -> Int {
		1
	}
}
