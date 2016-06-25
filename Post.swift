//
//  Post.swift
//  Parsetagram
//
//  Created by John Kriston on 6/22/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Post: NSObject {
    
    func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?){
        let post = PFObject(className: "Post")
        post["media"] = getPFFileFromImage(image)
        post["caption"] = caption
        post.saveInBackgroundWithBlock(completion)
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
