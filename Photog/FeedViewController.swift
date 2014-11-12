//
//  FeedViewController.swift
//  Photog
//
//  Created by Jack Mallers on 11/2/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
    
    var items = []
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "PostCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "PostCellIdentifier")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.sharedInstance.fetchFeed {
            (objects, error) -> () in
            
            if let constantObjects = objects {
                self.items = constantObjects
                self.tableView?.reloadData()
            } else if let constantError = error {
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellIdentifier") as PostCell
        var item = items[indexPath.row] as PFObject
        
        cell.post = item

        return cell
    }
    
}
