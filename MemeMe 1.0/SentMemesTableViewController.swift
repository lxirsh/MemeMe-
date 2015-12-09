//
//  SentMemesTableViewController.swift
//  MemeMe 1.0
//
//  Created by Lance Hirsch on 11/28/15.
//  Copyright © 2015 Lance Hirsch. All rights reserved.
//

import UIKit


class SentMemesTableViewController: UITableViewController {
    
    var savedMemes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).savedMemes
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadSampleMemes()
        
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        var savedMemes = applicationDelegate.savedMemes

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    func loadSampleMemes() {
//
//        let numberOfSampleMemes = 10
//        
//        for index in 0...numberOfSampleMemes {
//            let newIndex = (index % 3) + 1
//            let imageName = "meal\(newIndex)"
//            let image = UIImage(named: imageName)!
//            let meme = Meme(topText: "TOP", bottomText: "BOTTOM", image: image, memedImage: image)
//            (UIApplication.sharedApplication().delegate as! AppDelegate).savedMemes.append(meme)
//            
//        }
//    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedMemes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIndentifier = "MemeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! MemeTableViewCell

        let meme = savedMemes[indexPath.row] as Meme
//        cell.imageView?.image = meme.image
//        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.memeImage.image = meme.memedImage
        cell.memeText.text = meme.topText + "..." + meme.bottomText

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
//            savedMemes.removeAtIndex(indexPath.row)
//            appDelegate.memes.removeAtIndex(indexPath.row)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            let index = indexPath.row
            appDelegate.savedMemes.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: - Navigation

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemesDetailViewController") as! SentMemesDetailViewController
        detailController.meme = self.savedMemes[indexPath.row]
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
