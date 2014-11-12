//
//  SearchViewController.swift
//  Photog
//
//  Created by Jack Mallers on 11/4/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var tableView: UITableView?
    
    var searchResults = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "PersonCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: "PersonCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        var searchTerm = searchBar.text
        
        NetworkManager.sharedInstance.findUsers(searchTerm, completionHandler: {
            (objects, error) -> () in
            
            if let constantObjects = objects {
                self.searchResults = constantObjects
                self.tableView?.reloadData()
            } else if let constantError = error {
                // Alert the user
            }
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCellIdentifier") as PersonCell
        
        var user = self.searchResults[indexPath.row] as PFUser
        
        cell.user = user
        
        return cell
    }
}
