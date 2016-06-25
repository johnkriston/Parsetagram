//
//  HomeViewController.swift
//  Parsetagram
//
//  Created by John Kriston on 6/21/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var showposts : [PFObject]?
    
    
    
var isMoreDataLoading = false
    
    func loadMoreData(){
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.limit = 20
         query.orderByDescending("CreatedAt")
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                //  MBProgressHUD.hideHUDForView(self.view, animated:true)
                self.showposts = posts
                self.isMoreDataLoading = false
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
        
        // Do any additional setup after loading the view.
        
    }
    
    

    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
            isMoreDataLoading = true
                loadMoreData()
            }
        }
    }
    
   
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let showposts = showposts{
            return showposts.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        
        let post = showposts![indexPath.row]
                
        cell.instagramPost = post
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //MBProgressHUD.showHUDAddedTo(self.view,animated: true)
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.orderByDescending("CreatedAt")
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
               // MBProgressHUD.hideHUDForView(self.view, animated:true)
                self.showposts = posts
                self.tableView.reloadData()
                refreshControl.endRefreshing()
                
            } else {
                print(error?.localizedDescription)
            }
        
        }
        }
        
            
            
            func refreshControlAction(refreshControl: UIRefreshControl){
                
                //MBProgressHUD.showHUDAddedTo(self.view,animated: true)
                
                // construct PFQuery
                let query = PFQuery(className: "Post")
                query.limit = 20
                 query.orderByDescending("CreatedAt")
                
                // fetch data asynchronously
                query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
                    if let posts = posts {
                      //  MBProgressHUD.hideHUDForView(self.view, animated:true)
                        self.showposts = posts
                        self.tableView.reloadData()
                        refreshControl.endRefreshing()
                        
                    } else {
                        print(error?.localizedDescription)
                    }
                }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let post = showposts![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.image = post
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    
}
