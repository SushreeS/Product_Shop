//
//  ShoppingCartTableCell.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import UIKit

class ShoppingCartTableCell: UITableViewCell {

    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartProductNameLabel: UILabel!
    @IBOutlet weak var addedUnitsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var cartProductPriceLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        self.cartImageView.layer.cornerRadius = self.cartImageView.frame.size.height / 2
        self.cartImageView.clipsToBounds = true
    }
    
    public func updateView(_ product: Product) {
        DispatchQueue.main.async {
            self.cartProductNameLabel.text = product.productName
            self.cartProductPriceLabel.text = "$ " + String(describing: product.productPrice)
            self.cartImageView.image = UIImage(named: product.productImageName!)
            
            let unitsAdded = (product.productInventory?.productUnits)! - (product.productInventory?.closingProductUnits)!
            self.addedUnitsLabel.text = "Units added: " + String(describing: unitsAdded)
            
            let totalPrice : Double = Double(unitsAdded) * product.productPrice
            self.totalPriceLabel.text = String(describing: totalPrice)
        }
    }
    
}
