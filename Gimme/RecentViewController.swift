//
//  RecentController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 14/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController {
    
    private lazy var allProducts = [Product]()

    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ProductService.searchProducts({ (products) -> Void in
                self.allProducts.removeAll()
                self.allProducts+=products
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
        return allProducts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Création ou récupération d'une cellule depuis le cache
        let cell = tableView.dequeueReusableCellWithIdentifier(ProductTableViewCell.identifier, forIndexPath: indexPath) as! ProductTableViewCell
        
        cell.product = allProducts[indexPath.row]
        
        return cell
    }


}

