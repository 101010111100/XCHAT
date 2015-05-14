//
//  MainViewController.swift
//  XCHAT
//
//  Created by Jim Cai on 5/14/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToPage(sender: AnyObject) {
        var notificationStoryboard = UIStoryboard(name: "NotificationSettings", bundle: nil)
        if let resultController =        notificationStoryboard.instantiateViewControllerWithIdentifier("Settings") as? NotificationsSettingsViewController
        {
            presentViewController(resultController, animated: true, completion: nil)
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
