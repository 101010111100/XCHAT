//
//  ReelScrollViewController.swift
//  XCHAT
//
//  Created by Mateo Garcia on 5/19/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

// WHERE TO START
// - implement caption screen after photo selection (look at PhotoMap)
// - have cells set themselves up
// - add button functionality
//      - save fave
//      - add comment funcitonality (could be mimic of caption view)

class ReelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = NSMutableArray()
    var uploadImage: UIImage?
    
    var refreshControl: UIRefreshControl!
    
    let headerWidth = 320
    let headerHeight = 46
    let profileWidthHeight = 30
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Refresh
    
    func refreshData() {
        var query = PFQuery(className:"Photo")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                println("Successfully retrieved \(objects!.count) photos.")
                
                if let objects = objects as? [PFObject] {
                    self.photos.removeAllObjects()
                    
                    println("Adding photos to array")
                    var i = 0
                    
                    for object in objects {
                        var photo = NSMutableDictionary()
                        photo.setObject((object.objectForKey("imageName") as? String)!, forKey: "imageName")
                        photo.setObject(object.objectForKey("imageFile")!, forKey: "imageFile")
                        
                        println("\(i++)")
                        
                        photo.setObject(object.objectId!, forKey: "objectId")
                        self.photos.insertObject(photo, atIndex: 0)
                    }
                }
                
                self.tableView.reloadData()
                
            } else {
                
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func onRefresh() {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView=UIView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)   )
        headerView.backgroundColor = UIColor(white: 3, alpha: 0.5)
        
        var profilePicture = UIImageView(frame: CGRect(x: 8 , y: 8, width: profileWidthHeight, height: profileWidthHeight))
        profilePicture.backgroundColor = UIColor.redColor()
        
        // profilePicture.setImageWithURL(NSURL(string: url!)!)
        
        headerView.insertSubview(profilePicture, atIndex: 0)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.headerHeight)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
            var photo = photos.objectAtIndex(indexPath.section) as? NSMutableDictionary
            cell.setUpCell(photo)
            return cell
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell", forIndexPath: indexPath) as! ButtonCell
            
            // CONFIGURE WHETHER LIKED OR NOT
            
            return cell
        case 2:
            // if faves greater than zero, else do nothing
            
            var cell = tableView.dequeueReusableCellWithIdentifier("FavesCell", forIndexPath: indexPath) as! FavesCell
            
            // SET NUM FAVES
            
            return cell
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
            
            // SETUP
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    
    // MARK: Actions
    
    @IBAction func onAddButtonTapped(sender: AnyObject) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.allowsEditing = true
        imageVC.sourceType = .PhotoLibrary
        presentViewController(imageVC, animated: true, completion: nil) // FIXME: Causes warning 'Presenting view controllers on detached view controllers is discouraged'
    }
    
    
    // MARK: ImagePickerController
    
    // Triggered when the user finishes taking an image. Saves the chosen image to our temporary
    // uploadImage variable, and dismisses the image picker view controller. Once the image picker
    // view controller is dismissed (a.k.a. inside the completion handler) we modally segue to
    // show the "Location selection" screen. --Nick Troccoli
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        uploadImage = info[UIImagePickerControllerEditedImage] as? UIImage
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
            // self.performSegueWithIdentifier("addCaptionSegue", sender: self) // segue to CaptionViewController
            
            // then add below code to a protocol implementation for the CaptionViewController's protocol
            
            let imageData = UIImageJPEGRepresentation(self.uploadImage, 100)
            let imageFile = PFFile(name: "image.jpeg", data: imageData)
            
            var photo = PFObject(className:"Photo")
            photo["imageName"] = "Dis a picture!" // SET TO CAPTION NAME
            photo["imageFile"] = imageFile
            photo["numFaves"] = 0
            photo["numComments"] = 0
            photo.saveInBackgroundWithBlock(nil)
            
        })
        
        
    }
    
    
    // MARK: Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        vc.selectedPhoto = photos[indexPath.section] as! NSMutableDictionary
    }
    
}
