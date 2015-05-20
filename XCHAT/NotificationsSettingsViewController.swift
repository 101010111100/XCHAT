//
//  NotificationsSettingsViewController.swift
//  XCHAT
//
//  Created by Jim Cai on 5/13/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

class NotificationsSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchDelegate {

    var savedSettings = [String: Bool]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NTCell", forIndexPath: indexPath) as! NotificationsTableViewCell
        cell.delegate = self

        cell.label.text =  NotificationSettingConstants.settingsList[indexPath.row]
        if let switchOnValue=savedSettings[cell.label.text!]{
            cell.onSwitch.setOn(switchOnValue, animated: true)
        }else{
            cell.onSwitch.setOn(true, animated: true)
        }
        
        return cell
    }
   
    func switchDelegate(switchtableViewCell: NotificationsTableViewCell, switchValue: Bool) {
        savedSettings[switchtableViewCell.label.text!] = switchValue
        if switchValue{
            PushHelper.subscribeToChannel(switchtableViewCell.label.text!)
        }
        else{
            PushHelper.unsubscribeFromChannel(switchtableViewCell.label.text!)
            
        }
        //println(switchtableViewCell.label.text)
        //println(switchValue)
    }
}
