//
//  ProductTableViewCell.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit
import Haneke
import Alamofire


class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "product_cell"
    
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var sellerProductLabel: UILabel!
    @IBOutlet weak var backgroundProductImage: UIImageView!
    @IBOutlet weak var likeProductButton: UIButton!
    
    var product:Product! {
        didSet {
            nameProductLabel.text = product.name
            sellerProductLabel.text = product.seller
            
            likeProductButton.setTitle("\(product.like)", forState: .Normal)
            
            Alamofire.request(.GET, product.imageUrl).response() {
                (_, _, data, _) in
                let image = UIImage(data: data!)
                self.backgroundProductImage.image = image
            }
        }
    }
    
    @IBAction func openPurchaseUrl(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: product.purchaseUrl)!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
