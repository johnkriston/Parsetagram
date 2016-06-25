//
//  CaptureViewController.swift
//  Parsetagram
//
//  Created by John Kriston on 6/21/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
       @IBAction func takePhotoButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
  
    
    
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBAction func postButtonTapped(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(self.view,animated: true)
        postUserImage(posterView.image, caption: caption.text, completion: nil)
        MBProgressHUD.hideHUDForView(self.view,animated: true)
        self.performSegueWithIdentifier("homeSegue", sender: nil)
    }

    func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?){
        let post = PFObject(className: "Post")
        post["caption"] = caption
        post["author"] = PFUser.currentUser()
        if let imageNotNil = image {
        let resizedImage = resize(imageNotNil, newSize: CGSize(width: 500, height: 500))
        post["media"] = getPFFileFromImage(resizedImage)
        }
        
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)

    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
 
    
    
    
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            posterView.contentMode = .ScaleAspectFit
            posterView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
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
