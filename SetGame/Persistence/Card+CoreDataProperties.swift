//
//  Card+CoreDataProperties.swift
//  SetGame
//
//  Created by Slava Rykov on 14.02.2025.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int64
    @NSManaged public var isInSet: Bool
    @NSManaged public var isSelected: Bool
    @NSManaged public var quantity: Int16
    @NSManaged public var shade: String?
    @NSManaged public var shape: String?
	@NSManaged public var orderIndex: Int16
}

extension Card : Identifiable {

}
