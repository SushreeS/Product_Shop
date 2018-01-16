//
//  ProductListViewController.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import UIKit

var productListReuseIdentifier = "ProductListTableCell"

public struct Productt: Decodable {
    var name : String
    var id : Int64
    var imageName : String
    var description : String
    var unitsInStock : Int64
    var price : Double
}

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tblProductList: UITableView!
    var products : [Product]?
    var cartItems : NSSet?
    
    var btnBuy :UIButton?
    var itemsInList : Int = 0
    var cartNotificationButton: BadgeButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getProductList()
    }
    
    func setup() {
        
        let nib = UINib.init(nibName: productListReuseIdentifier, bundle: nil)
        tblProductList.register(nib, forCellReuseIdentifier: productListReuseIdentifier)
        
        setupCartNotificationButton()
        
        getProductList()
        
        getCartItems()
        itemsInList = cartItems?.count ?? 0
        cartNotificationButton?.badge = String(describing: itemsInList)
    }
    
    func getProductList() {
        self.products = CoreDataManager.getProductList()
        if self.products?.count == 0 || self.products == nil {
            parseLocalJSON()
        }
    }
    
    func getCartItems() {
        let cartList = CoreDataManager.getCartList()
        if cartList?.count != 0  {
            cartItems = (cartList![0]).cartProducts!
            print(cartItems?.count ?? 0)
        }
    }
    
    func setupCartNotificationButton() {
        cartNotificationButton = BadgeButton()
        cartNotificationButton?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cartNotificationButton?.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartNotificationButton?.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        cartNotificationButton?.addTarget(self, action: #selector(ProductListViewController.showShoppingCartVC), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartNotificationButton!)
    }
    
    @objc public func showShoppingCartVC() {
        let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.ShopingCartViewController) as! ShopingCartViewController
        modalViewController.modalPresentationStyle = .fullScreen
        present(modalViewController, animated: true, completion: nil)
    }
    
    func parseLocalJSON() {
        self.startLoader()
        DataManager.getJSONFromURL("ProductList") { (data, error) in
            let decoder = JSONDecoder()
            do {
                let productList = try decoder.decode([Productt].self, from: data!)
                print(productList)
                
                DispatchQueue.main.async {
                    CoreDataManager.saveProducts(productList)
                    self.products = CoreDataManager.getProductList()
                    
                    self.tblProductList.reloadData()
                    
                    self.stopLoader()
                }
            } catch let exception {
                print("failed to convert data \(exception)")
                self.stopLoader()
            }
        }
    }
    
    func startLoader() {
        
    }
    
    func stopLoader() {
        
    }
    
    @objc func addToCart(_ sender:UIButton) {
        let rowIndex = sender.tag
        let product = self.products![rowIndex]
        
        itemsInList = itemsInList + 1
        cartNotificationButton?.badge = String(describing: itemsInList)
        
        CoreDataManager.updateProductUnits(product)
        CoreDataManager.addToCart(product)
        
        updateTable()
    }
    
    func updateTable() {
        self.products = CoreDataManager.getProductList()
        self.tblProductList.reloadData()
    }

}

//MARK: Extensions

extension ProductListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.products != nil {
            return self.products!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productListReuseIdentifier, for: indexPath) as! ProductListTableCell
        cell.updateView(self.products![indexPath.row])
        cell.buyButton?.tag = indexPath.row
        cell.buyButton?.addTarget(self, action: #selector(ProductListViewController.addToCart(_:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
