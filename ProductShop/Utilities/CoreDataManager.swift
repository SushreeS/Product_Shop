//
//  CoreDataManager.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static func saveProducts(_ products:[Productt]?) {
        for product in products! {
            let eachProduct = Product(context: PersistentManager.context)
            eachProduct.productId = product.id
            eachProduct.productName = product.name
            eachProduct.productDescription = product.description
            eachProduct.productImageName = product.imageName
            eachProduct.productPrice = product.price
            
            let unitsAvailable = product.unitsInStock
            
            let inventory = Inventory(context: PersistentManager.context)
            inventory.productId = eachProduct.productId
            inventory.productUnits = unitsAvailable
            inventory.closingProductUnits = unitsAvailable
            
            eachProduct.productInventory = inventory
            
            PersistentManager.saveContext()
        }
    }
    
    static func getProductList() -> [Product]? {
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let productList: [Product] = try PersistentManager.context.fetch(fetchRequest)
            return productList
        }
        catch {
        }
        return nil
    }
    
    static func deleteProductList() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let productList: [Product] = try PersistentManager.context.fetch(fetchRequest)
            
            for product in productList {
                PersistentManager.context.delete(product)
            }
            PersistentManager.saveContext()
        } catch {
        }
    }
    
    static func updateProductUnits(_ product: Product) {
        let productId = product.productId
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == %d", productId)
        
        do {
            let products : [Product] = try PersistentManager.context.fetch(fetchRequest)
            if products.count > 0 {
                let productToUpdate = products[0]
                productToUpdate.productInventory?.closingProductUnits = (productToUpdate.productInventory?.closingProductUnits)! - 1
            }
            PersistentManager.saveContext()
        }
        catch {
            
        }
    }
    
    // Cart section
    
    static func addToCart(_ product:Product) {

        var cart :Cart?
        let cartList = self.getCartList()!
        if cartList.count == 0 {
            cart = Cart(context: PersistentManager.context)
        }else {
            cart = cartList[0]
        }
        
        let cartProducts = cart?.mutableSetValue(forKey: #keyPath(Cart.cartProducts))
        cartProducts?.add(product)
        
        PersistentManager.saveContext()
    }
    
    static func getCartList() -> [Cart]? {

        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let cartList: [Cart] = try PersistentManager.context.fetch(fetchRequest)
            print(cartList)
            return cartList
        }
        catch {
        }
        return nil
    }
    
    static func deleteProductFromCart(_ product:Product) {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let carts : [Cart] = try PersistentManager.context.fetch(fetchRequest)
            if carts.count > 0 {
                let currentCart = carts[0] as Cart
                let currentCartProducts = currentCart.mutableSetValue(forKey: #keyPath(Cart.cartProducts))
                
                for cartProduct in currentCartProducts {
                    if (cartProduct as! Product).productId == product.productId {
                        currentCartProducts.remove(cartProduct)
                    }
                }
                PersistentManager.saveContext()
            }
            PersistentManager.saveContext()
        }
        catch {
        }
    }
    
}
