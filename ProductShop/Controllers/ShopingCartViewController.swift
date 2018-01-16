//
//  ShopingCartViewController.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import UIKit

var shoppingCartReuseIdentifier = "ShoppingCartTableCell"

class ShopingCartViewController: UIViewController {

    var cartItems : NSSet?
    
    @IBOutlet weak var tblCart: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func getCartItems() {
        let cartList = CoreDataManager.getCartList()
        if cartList?.count != 0  {
            cartItems = (cartList![0]).cartProducts!
            print(cartItems?.count ?? 0)
        }
        
    }
    
    func setup() {
        getCartItems()
        
        let nib = UINib.init(nibName: shoppingCartReuseIdentifier, bundle: nil)
        tblCart.register(nib, forCellReuseIdentifier: shoppingCartReuseIdentifier)       
    }

    @IBAction func dismissController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteFromCart(_ sender:UIButton) {
        let rowIndex = sender.tag
        let product : Product = self.cartItems?.allObjects[rowIndex]  as! Product
        
        CoreDataManager.deleteProductFromCart(product)
        updateTable()
    }
    
    func updateTable() {
        getCartItems()
        self.tblCart.reloadData()
    }
}

//MARK: Extensions

extension ShopingCartViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCartReuseIdentifier, for: indexPath) as! ShoppingCartTableCell
        
        let item : Product = self.cartItems!.allObjects[indexPath.row] as! Product
        cell.updateView(item)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(ShopingCartViewController.deleteFromCart(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
