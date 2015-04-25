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
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as Scene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
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
        
        let currentLevelIndex = user["currentLevel"] as NSInteger
        let currentLevel: Level = self.levels[currentLevelIndex]

        
        loadLevel(currentLevel)
    }
    
    /* Configure levels */
    func configureLevels( levels:NSArray ) {
        for level in levels {
            println(level)
        }
    }

    
    /* Load and Present a Given Level */
    func loadLevel( level: Level ) {
        
        // Load Scene from scenefile
        if let scene = Scene.unarchiveFromFile(level.sceneFile) as? Scene {
            
            NSLog("%@", scene)
            
            scene.scaleMode = .AspectFill
            
            // Present Scene
            let skView = self.view as SKView
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
            
            

            // DEBUG
//            print("rendered level: ")
//            println(level)
        } else {
            NSLog("In loadLevel: Unable to unarchive Scene from file: %@", level.sceneFile)
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
