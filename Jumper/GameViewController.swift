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

class GameViewController: UIViewController, LevelDelegate {
    
    /* Instance Variables */
    let sceneFiles = []
    let levels = [
        Level(sceneFile: "level-one"),
        Level(sceneFile: "level-two"),
        Level(sceneFile: "level-three"),
        Level(sceneFile: "level-four"),
        Level(sceneFile: "level-five")
    ]
    var user = PFUser.currentUser()
    
    
    
    /* Init Methods */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLevels(self.levels)
    }
    
    /* View Will Appear */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentLevelIndex = user["currentLevel"] as! NSInteger
        let currentLevel: Level = self.levels[currentLevelIndex]
        
        loadLevel(currentLevel)
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
    
    /*
    * Level Delegate
    */
    func levelDidComplete() {
        let currentLevelIndex = user["currentLevel"] as! NSInteger
        let nextLevelIndex = currentLevelIndex + 1
        user["currentLevel"] = nextLevelIndex
        
        user.saveInBackgroundWithBlock { (success, error) -> Void in
            if (!success) {
                NSLog("Error saving user", error)
            }
        }
        
        if (nextLevelIndex < levels.count) {
            let nextLevel: Level = self.levels[nextLevelIndex]
            loadLevel(nextLevel)
        } else {
            NSLog("Game over!")
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
