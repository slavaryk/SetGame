//
//  PersistenceService.swift
//  SetGame
//
//  Created by Slava Rykov on 14.02.2025.
//

import Foundation
import CoreData

class PersistenceService {
	static let shared = PersistenceService()

	private let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Model")

		container.loadPersistentStores(completionHandler: { (_, error ) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})

		return container
	}()

	private var context: NSManagedObjectContext {
		persistentContainer.viewContext
	}

	private func createNewCard(
		id: Int64,
		color: String,
		isInSet: Bool,
		quantity: Int16,
		shade: String,
		shape: String,
		orderIndex: Int16
	) {
		let card = Card(context: context)

		card.id = id
		card.color = color
		card.isInSet = isInSet
		card.quantity = quantity
		card.shade = shade
		card.shape = shape
		card.isSelected = false
		card.orderIndex = orderIndex
	}

	func getSavedCards() -> [Card] {
		let cardFetchRequest = Card.fetchRequest()
		cardFetchRequest.sortDescriptors = [NSSortDescriptor(key: "orderIndex", ascending: true)]
		let cards = try? context.fetch(cardFetchRequest)

		print(cards?.count)

		return cards ?? []
	}

	func saveNewCards(from cards: [SetGame.Card]) {
		do {
			for index in 0..<cards.count {
				let card = cards[index]

				createNewCard(
					id: Int64(card.id),
					color: card.color.toString(),
					isInSet: card.isInSet,
					quantity: card.quantity.toInt(),
					shade: card.shading.toString(),
					shape: card.shape.toString(),
					orderIndex: Int16(index + 1)
				)
			}

			try context.save()
		} catch {
			fatalError("Data didn't save!")
		}
	}

	func saveCards(cardList: [SetGame.Card], isInSet: Bool) {
		do {
			cardList.forEach { card in
				let currentCard = getSavedCards().first {
					Int($0.id) == card.id
				}

				if let safeCurrentCard = currentCard {
					safeCurrentCard.isInSet = isInSet
				}
			}

			try context.save()
		} catch {
			fatalError("Card data didn't save!")
		}
	}

	func clear() {
		for card in getSavedCards() {
			context.delete(card)
		}
	}
}
