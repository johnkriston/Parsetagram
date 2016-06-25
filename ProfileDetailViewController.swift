//
//  ProfileDetailViewController.swift
//  Parsetagram
//
//  Created by John Kriston on 6/24/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var image: PFObject!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let caption = image["caption"] as? String
        captionLabel.text = caption
        
        let timestamp = image.createdAt
        timestampLabel.text = timestamp?.description
        
        

        

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
