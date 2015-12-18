//
//  SingleCategoryViewController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 17/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit

class SingleCategoryViewController: UIViewController {
    
    var categorySelected : String = ""
    var categoryBool : Bool = false
    private lazy var allProducts = [Product]()
    private lazy var filteredProducts = [Product]()
    
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ProductService.searchProducts({ (products) -> Void in
            self.allProducts.removeAll()
            self.allProducts+=products
            self.filteredProducts.removeAll()
            
            for singleProduct in self.allProducts{
                for category in singleProduct.categories{
                    if(category == self.categorySelected){
                        self.categoryBool = true
                    }
                }
                if(self.categoryBool){
                    self.filteredProducts.append(singleProduct)
                    self.categoryBool = false
                }
            }
            
            self.productsTableView.reloadData()
            }) { (error) -> Void in
        }
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15)!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 254.0/255, green: 40.0/255, blue: 81.0/255, alpha: 1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController!.navigationBar.topItem!.title = categorySelected.uppercaseString;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier = segue.identifier {
            
            switch(segueIdentifier) {
            case ProductDetailViewController.identifier:
                
                let productDetailViewController = segue.destinationViewController as! ProductDetailViewController
                
                if let indexPathForSelectedRow = productsTableView.indexPathForSelectedRow {
                    let product = allProducts[indexPathForSelectedRow.row]
                    productDetailViewController.product = product
                    
                    productsTableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
                }
                
                
                break
            default:
                
                break
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Création ou récupération d'une cellule depuis le cache
        let cell = tableView.dequeueReusableCellWithIdentifier(ProductTableViewCell.identifier, forIndexPath: indexPath) as! ProductTableViewCell
        
        cell.product = filteredProducts[indexPath.row]
        
        return cell
    }
    
}
