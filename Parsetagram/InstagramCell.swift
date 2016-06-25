//
//  InstagramCell.swift
//  Parsetagram
//
//  Created by John Kriston on 6/22/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var posterView: PFImageView!
    
    
    var instagramPost: PFObject! {
        didSet {
            captionLabel.text = instagramPost["caption"] as? String
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
