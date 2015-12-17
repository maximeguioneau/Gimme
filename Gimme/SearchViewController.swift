//
//  SearchViewController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 16/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchActive : Bool = false
    private lazy var allProducts = [Product]()
    private lazy var filteredProducts = [Product]()
    
    @IBOutlet weak var productsSearchBar: UISearchBar!
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredProducts = allProducts.filter({ (text) -> Bool in
            let tmp: NSString = text.name + " " + text.seller
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredProducts.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.productsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 254.0/255, green: 40.0/255, blue: 81.0/255, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier = segue.identifier {
            
            switch(segueIdentifier) {
            case ProductDetailViewController.identifier:
                
                let productDetailViewController = segue.destinationViewController as! ProductDetailViewController
                
                if (searchActive) {
                    if let indexPathForSelectedRow = searchDisplayController?.searchResultsTableView.indexPathForSelectedRow {
                        
                        let product = filteredProducts[indexPathForSelectedRow.row]
                        productDetailViewController.product = product
                        
                        productsTableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
                    }
                }
                else{
                    if let indexPathForSelectedRow = productsTableView.indexPathForSelectedRow {
                        
                        let product = allProducts[indexPathForSelectedRow.row]
                        productDetailViewController.product = product
                        
                        productsTableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
                    }
                }
                
                break
            default:
                
                break
            }
            
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredProducts.count
        }
        return allProducts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = productsTableView.dequeueReusableCellWithIdentifier("product_cell")! as UITableViewCell
        if(searchActive && filteredProducts.count > 0){
            cell.textLabel?.text = filteredProducts[indexPath.row].name
            cell.detailTextLabel?.text = filteredProducts[indexPath.row].seller
        } else {
            cell.textLabel?.text = allProducts[indexPath.row].name
            cell.detailTextLabel?.text = allProducts[indexPath.row].seller
        }
        
        return cell;
    }
    
}

