//
//  MenuViewController.swift
//  XCHAT
//
//  Created by Mateo Garcia on 5/13/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hamburgerViewController: HamburgerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Table View
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! UITableViewCell
            return cell
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("ThreadsCell") as! UITableViewCell
            return cell
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("CalendarCell")as! UITableViewCell
            return cell
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier("ReelCell")as! UITableViewCell
            return cell
        case 4:
            var cell = tableView.dequeueReusableCellWithIdentifier("MembersCell") as! UITableViewCell
            return cell
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell") as! UITableViewCell
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print(indexPath.row)
        switch indexPath.row {
        case 1:
            var threadsStoryboard = UIStoryboard(name: "Threads", bundle: nil)
            var chatNavigationController = threadsStoryboard.instantiateViewControllerWithIdentifier("Nav") as! UINavigationController
            hamburgerViewController?.contentViewController = chatNavigationController
            //threads
        case 2:
            var eventsStoryboard = UIStoryboard(name: "Events", bundle: nil)
            var eventsNavigationController = eventsStoryboard.instantiateViewControllerWithIdentifier("Nav") as! UINavigationController
            hamburgerViewController?.contentViewController = eventsNavigationController
            //calendar
        case 3:
            var reelStoryboard = UIStoryboard(name: "Reel", bundle: nil)
            var reelNavigationController = reelStoryboard.instantiateViewControllerWithIdentifier("Nav") as! UINavigationController
            hamburgerViewController?.contentViewController = reelNavigationController
            //reel
        case 4:
            1
            //members
        case 5:
            var threadsStoryboard = UIStoryboard(name: "NotificationSettings", bundle: nil)
            var notificationSettingsController = threadsStoryboard.instantiateViewControllerWithIdentifier("Settings") as! NotificationsSettingsViewController
            hamburgerViewController?.contentViewController = notificationSettingsController
            //settings
        default:
            var profileViewController = storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
            
            // SETUP PROFILE
            
            hamburgerViewController?.contentViewController = profileViewController
//        default:
//            var chatNavigationController = storyboard!.instantiateViewControllerWithIdentifier("ChatNavigationController") as! UINavigationController
//            var chatViewController = chatNavigationController.viewControllers[0] as! ChatViewController
//            hamburgerViewController?.contentViewController = chatNavigationController
        }
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
