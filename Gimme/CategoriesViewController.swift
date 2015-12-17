//
//  CategoriesViewController.swift
//  Gimme
//
//  Created by Maxime Guioneau on 15/12/2015.
//  Copyright © 2015 Maxime Guioneau. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private var categories = ["hi-tech", "horlogerie"]
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15)!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
    
    
}
