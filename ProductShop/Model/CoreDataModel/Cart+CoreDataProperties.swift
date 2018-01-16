//
//  Cart+CoreDataProperties.swift
//  
//
//  Created by Sushree Swagatika on 16/01/18.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var cartId: Int64
    @NSManaged public var cartTotalPrice: Double
    @NSManaged public var cartTotalQuantity: Int64
    @NSManaged public var cartProducts: NSSet?

}

// MARK: Generated accessors for cartProducts
extension Cart {

    @objc(addCartProductsObject:)
    @NSManaged public func addToCartProducts(_ value: Product)

    @objc(removeCartProductsObject:)
    @NSManaged public func removeFromCartProducts(_ value: Product)

    @objc(addCartProducts:)
    @NSManaged public func addToCartProducts(_ values: NSSet)

    @objc(removeCartProducts:)
    @NSManaged public func removeFromCartProducts(_ values: NSSet)

}
