//
//  LevelViewController.swift
//  Jumper
//
//  Created by Jenna Raderstrong on 4/23/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import Foundation

import UIKit
import Parse

class LevelViewController: UITableViewController, UITableViewDelegate
{
    let levels = (UIApplication.sharedApplication().delegate! as! AppDelegate).levels
    var selectedItem :AnyObject? = nil
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
            return self.levels.count
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell {
        
        let user = PFUser.currentUser()
//        let currentLevelIndex: NSInteger = user["currentLevelIndex"]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel!.text = "Level \(indexPath.row + 1)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = self.levels[indexPath.row]
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "selectLevel") {
            let gameViewController = segue.destinationViewController as! GameViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let selectedLevel = self.levels[indexPath.row]
            
            gameViewController.loadLevel(selectedLevel)
        }
    }
}


