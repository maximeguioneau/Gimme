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
    
    private static let urlSearchProducts = "http://api.themoviedb.org/3/search/movie?api_key=c1ac741d5dd740f9861e794c5363b0c2&query="
    
    static func searchProducts(title:String, resultCallback:ResultProduct, errorCallback:FailureHandler) {
        
        let url = urlSearchProducts+title.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            switch response.result {
            case .Success(let value):
                
                let products = Product.productsFromJson(value)
                resultCallback(products: products)
                
                break
            case .Failure(let error):
                
                errorCallback(error: error)
                
                break
            }
        }
    }
    
}
