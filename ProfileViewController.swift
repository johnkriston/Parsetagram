//
//  ProfileViewController.swift
//  Parsetagram
//
//  Created by John Kriston on 6/21/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func Logout(sender: UIButton) {
        PFUser.logOutInBackgroundWithBlock({(error: NSError?) -> Void in } )
        // PFUser.currentUser() will now be nil
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var isMoreDataLoading = false
    
    var showposts: [PFObject]?
    
    //func imageForIndexPath(indexPath:NSIndexPath) -> PFFile



  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let images = showposts{
            return images.count
        }
            else{
                return 0
            }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ParsetagramCell", forIndexPath: indexPath) as! ProfileCell
        
        let post = showposts![indexPath.row]
        
        cell.instagramPost = post
        
        return cell

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                loadMoreData()
            }
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.orderByDescending("CreatedAt")
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.showposts = posts
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }

        // Do any additional setup after loading the view.
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
        
        let detailViewController = segue.destinationViewController as! ProfileDetailViewController
        detailViewController.image = post
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
