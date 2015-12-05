//
//  SentMemesDetailViewController.swift
//  MemeMe 1.0
//
//  Created by Lance Hirsch on 12/3/15.
//  Copyright © 2015 Lance Hirsch. All rights reserved.
//

import UIKit

class SentMemesDetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Edit",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "edit")

        // Do any additional setup after loading the view.
    }
    
    func edit() {
        let rootViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeNavigationController") as! UINavigationController
        let topViewController = rootViewController.topViewController as! MemeViewController
        topViewController.sentMeme = meme
        self.navigationController!.presentViewController(rootViewController, animated: true, completion: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
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
