//
//  Product.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product: NSObject {
    
    var name:String!
    var seller:String!
    var price:Int!
    var imageUrl:String!
    var purchaseUrl:String!
    var categories:Array<String>!
    var like:Int!
    var info:String!
    
    override init() {
        
    }
    
    init(name:String, seller:String, price:Int, imageUrl:String, purchaseUrl:String, categories:Array<String>, like:Int, info:String) {
        self.name = name
        self.seller = seller
        self.price = price
        self.imageUrl = imageUrl
        self.purchaseUrl = purchaseUrl
        self.categories = categories
        self.like = like
        self.info = info
    }
}

extension Product {
    
    convenience init(json:JSON) {
        self.init()
        self.name = json["name"].string ?? ""
        self.seller = json["seller"].string ?? ""
        self.price = json["price"].int ?? 0
        self.imageUrl = json["item_url"].string ?? ""
        self.purchaseUrl = json["purchase_url"].string ?? ""
        self.like = json["like"].int ?? 0
        self.info = json["description"].string ?? ""
        
        self.categories = json["category"].arrayValue.map { $0.string!}
        
    }
    
    static func productsFromJson(json:AnyObject) -> [Product] {
        
        var products = [Product]()
        
        let jsonObject = JSON(json)
        
        if let productResults = jsonObject.array {
            for productResult in productResults {
                products.append(Product(json: productResult))
            }
        }
        
        return products
        
    }
    
}
