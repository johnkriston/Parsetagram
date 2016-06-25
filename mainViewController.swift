//
//  mainViewController.swift
//  Parsetagram
//
//  Created by John Kriston on 6/21/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse

class mainViewController: UIViewController {
    
    @IBAction func Logout(sender: UIButton) {
        PFUser.logOutInBackgroundWithBlock
            { (error: NSError?) in
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
