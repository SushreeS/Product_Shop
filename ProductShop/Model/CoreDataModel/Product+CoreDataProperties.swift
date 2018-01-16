//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Sushree Swagatika on 16/01/18.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productId: Int64
    @NSManaged public var productImageName: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productInventory: Inventory?

}
