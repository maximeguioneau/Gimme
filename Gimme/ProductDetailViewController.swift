//
//  ProductDetailViewController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit
import Haneke
import Alamofire

class ProductDetailViewController: UIViewController {
    
    static let identifier = "product_detail_identifier"
    
    var product:Product!
    
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var sellerProductLabel: UILabel!
    @IBOutlet weak var backgroundProductImage: UIImageView!
    @IBOutlet weak var likeProductButton: UIButton!
    @IBOutlet weak var purchaseProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    
    @IBAction func openPurchaseUrl(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: product.purchaseUrl)!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15)!]
        
        refreshUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshUI() {
        nameProductLabel.text = product.name
        sellerProductLabel.text = product.seller
        purchaseProductLabel.text = product.purchaseUrl
        priceProductLabel.text = "\(product.price)€"
        
        likeProductButton.setTitle("\(product.like)", forState: .Normal)
        
        Alamofire.request(.GET, product.imageUrl).response() {
            (_, _, data, _) in
            let image = UIImage(data: data! as! NSData)
            self.backgroundProductImage.image = image
        }
    }
    
}
