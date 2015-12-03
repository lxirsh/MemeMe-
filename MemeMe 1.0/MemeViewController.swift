//
//  MemeViewController.swift
//  MemeMe 1.0
//
//  Created by Lance Hirsch on 10/12/15.
//  Copyright © 2015 Lance Hirsch. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    //@IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: NSNumber (float: -3.0)
    ]
    
//    var savedMemes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        
        // Disable the camera button if camera is not available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
        // Set attributes for the placehoder text in the two text fields
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        // Text field attributes
        stylizeTextFields(topTextField)
        stylizeTextFields(bottomTextField)
        
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Disable the action button if a photo has not been chosen
        actionButton.enabled = self.imageView.image != nil

        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.cameraCaptureMode = .Photo
            presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func selectPhoto(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {
            (activityType: String?, completed: Bool, returnedItems: [AnyObject]?, activityError: NSError?) -> Void in
            if completed {
                self.saveMeme()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Methods
    
    // Set attributes for the text fields
    func stylizeTextFields(textField: UITextField) {
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.borderStyle = UITextBorderStyle.None
        textField.backgroundColor = UIColor.clearColor()

    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
//        bottomToolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
//        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: memedImage)
        (UIApplication.sharedApplication().delegate as! AppDelegate).savedMemes.append(meme)
        print("Memes:  \((UIApplication.sharedApplication().delegate as! AppDelegate).savedMemes)")
    }

    // Shift the view up when keyboardWillShow notification is received
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // Shift the keyboard back down
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    
    // MARK: NSNotifications
    
    // Subscription to and unsubscription from NSNotifications for the keybaorad
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: UITextFieldDelegate
    
    // Dismiss the keyboard when return key is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = chosenImage
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

