//
//  ProductListTableCell.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import UIKit

class ProductListTableCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var unitsAvailableLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        self.productImageView.layer.cornerRadius = self.productImageView.frame.size.height / 2
        self.productImageView.clipsToBounds = true
    }
    
    public func updateView(_ product: Product) {        
        DispatchQueue.main.async {
            self.nameLabel.text = product.productName
            self.descriptionLabel.text = product.productDescription
            self.unitsAvailableLabel.text = String(describing: (product.productInventory?.closingProductUnits)!)
            self.priceLabel.text = "$ " + String(describing: product.productPrice)
            self.productImageView.image = UIImage(named: product.productImageName!)
        }
    }
    
}
