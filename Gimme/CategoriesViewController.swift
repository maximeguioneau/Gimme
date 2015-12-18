//
//  CategoriesViewController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private lazy var allProducts = [Product]()
    
    private var categories:Array<String> = []
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ProductService.searchProducts({ (products) -> Void in
            self.allProducts.removeAll()
            self.allProducts+=products
        
            for singleProduct in self.allProducts{
                for category in singleProduct.categories{
                    if self.categories.indexOf(category) == nil {
                        self.categories.append(category)
                    }
                }
            }
            
            self.categories = self.categories.sort(<)
            
            self.categoriesTableView.reloadData()
            
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
        self.navigationController!.navigationBar.topItem!.title = "CATEGORIES";
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "single_category_identifier" {
            if let destination = segue.destinationViewController as? SingleCategoryViewController {
                if let categoryIndex = categoriesTableView.indexPathForSelectedRow?.row {
                    destination.categorySelected = categories[categoryIndex]
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Création ou récupération d'une cellule depuis le cache
        let cell = categoriesTableView.dequeueReusableCellWithIdentifier("category_cell")! as UITableViewCell
        
        cell.textLabel?.text = categories[indexPath.row].capitalizedString
        
        return cell
    }
    
    
}
