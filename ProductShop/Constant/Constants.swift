//
//  Constants.swift
//  ProductShop
//
//  Created by Sushree Swagatika on 16/01/18.
//  Copyright © 2018 Sushree Swagatika. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    let SYSTEM_VERSION = UIDevice.current.systemVersion
    
    struct StoryboardIdentifier {
        static let ProductListViewController = "ProductListViewController"
        static let ShopingCartViewController = "ShopingCartViewController"
    }
    
    func IS_IPAD() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return false
        case .pad:
            return true
        case .unspecified:
            return false
        default:
            return false
        }
    }
    
    func sharedAppDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
