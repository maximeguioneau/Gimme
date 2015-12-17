//
//  ProductService.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit
import Alamofire

class ProductService: NSObject {
    
    typealias ResultProduct = (products:[Product]) -> Void
    typealias FailureHandler = (error:NSError) -> Void
    
    private static let urlSearchProducts = "http://jaiye.com/DONOTTOUCH.json"
    
    static func searchProducts(resultCallback:ResultProduct, errorCallback:FailureHandler) {
        
        let url = urlSearchProducts.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            switch response.result {
            case .Success(let value):
                
                let products = Product.productsFromJson(value)
                
                print(products)
                
                resultCallback(products: products)
                
                break
            case .Failure(let error):
                
                errorCallback(error: error)
                
                break
            }
        }
    }
    
}
