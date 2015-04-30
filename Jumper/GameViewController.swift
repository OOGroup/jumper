//
//  GameViewController.swift
//  Jumper
//
//  Created by Dillon Drenzek on 2/19/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import UIKit
import SpriteKit
import Parse

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! Scene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, UIAlertViewDelegate, LevelDelegate {
    
    /* Instance Variables */
    let sceneFiles = []
    var current:AnyObject?
    let levels = (UIApplication.sharedApplication().delegate! as! AppDelegate).levels
    var user = PFUser.currentUser()
    
    var currentLevelIndex: NSInteger = 0
    
    
    
    /* Init Methods */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLevels(levels)
        currentLevelIndex = user["currentLevelIndex"] as! NSInteger
    }
    
    /* View Will Appear */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /* Configure levels */
    func configureLevels( levels:NSArray ) {
        for level in levels {
            (level as! Level).levelDelegate = self
        }
    }

    
    /* Load and Present a Given Level */
    func loadLevel( level: Level ) {
        
        if (level.scene != nil) {
            
            // Present Scene
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            skView.presentScene(level.scene!)
            
        } else {
            NSLog("In loadLevel: Unable to unarchive Scene from file: %@", level.sceneFile)
        }
    }
    
    func nextLevel() {
        let nextLevelIndex = currentLevelIndex+1
        let userLevelIndex = user["currentLevelIndex"] as! NSInteger
        if (nextLevelIndex > userLevelIndex) {
            
        }
        currentLevelIndex = nextLevelIndex
        loadLevel(levels[nextLevelIndex])
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch (buttonIndex) {
        case 0:
            loadLevel(levels[currentLevelIndex])
            break
        case 1:
            nextLevel()
            break
        default:
            break
        }
    }
    
    /*
    * Level Delegate
    */
    func levelDidComplete(score:NSInteger) {
        
        if (currentLevelIndex < levels.count-1) {
            
//            UIAlertView(title: "Level Complete", message: "You probably scored really well!", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "Replay", "Next Level").show()
            UIAlertView(title: "Level Complete", message: "Score: \(score)", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "Replay", "Next Level").show()
            
            let userLevelIndex = user["currentLevelIndex"] as! NSInteger
            if (currentLevelIndex == userLevelIndex) {
                user["currentLevelIndex"] = currentLevelIndex + 1
                user.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if (!success) {
                        NSLog("Error saving user", error)
                    }
                })
            }
        }
    }

    /* Default View Setup Methods*/
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.Landscape.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    override func shouldAutorotate() -> Bool { return true }
    override func prefersStatusBarHidden() -> Bool { return true }
}
