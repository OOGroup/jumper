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
    let items = ["Level 1", "Level 2", "Level 3"]
    var selectedItem :AnyObject? = nil
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
            return self.items.count
    }
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell {
            let item = self.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = item
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let selectedItem = self.items[indexPath.row]
        //objectAtIndex(indexPath.row) as String
        
//        self.
        
//        let selectedItem = items.objectAtIndex(indexPath.row) as String
//        let itemId = selectedItem.componentsSeparatedByString("$%^")
//        // add to self.selectedItems
//        selectedItems[itemId[1]] = true
//        let selectedItem = items.objectAtIndex(indexPath.row) as NSInteger
//        
//        let level: Level = levelsArray[selectedItem]
//        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Load View") {
            let gameViewController = segue.destinationViewController as GameViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let selectedItem = self.items[indexPath.row]
            gameViewController.current = selectedItem
            //GameViewController.current = selectedItem
        }
    }
}


