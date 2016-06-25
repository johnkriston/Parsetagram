//
//  ProfileCell.swift
//  Parsetagram
//
//  Created by John Kriston on 6/23/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileCell: UITableViewCell {


    @IBOutlet weak var posterView: PFImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var instagramPost: PFObject! {
        didSet {
            overviewLabel.text = instagramPost["caption"] as? String
            self.posterView.file = instagramPost["media"] as? PFFile
            self.posterView.loadInBackground()
        }
    }
 

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
