//
//  Inventory+CoreDataProperties.swift
//  
//
//  Created by Sushree Swagatika on 16/01/18.
//
//

import Foundation
import CoreData


extension Inventory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventory> {
        return NSFetchRequest<Inventory>(entityName: "Inventory")
    }

    @NSManaged public var closingProductUnits: Int64
    @NSManaged public var inventoryId: Int64
    @NSManaged public var productId: Int64
    @NSManaged public var productUnits: Int64

}
