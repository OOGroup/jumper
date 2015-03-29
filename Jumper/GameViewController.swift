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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let user:PFUser = PFUser.currentUser()
        let currentLevel = user["currentLevel"] as NSInteger

        loadLevel(currentLevel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadLevel( level:NSInteger ) {
        
        var sceneFile:NSString
        
        switch (level) {
        case 1:
            sceneFile = "level-one"
        case 2:
            sceneFile = "level-two"
        case 3:
            sceneFile = "level-three"
        default:
            return
        }
        
        if let scene = Scene.unarchiveFromFile(sceneFile) as? Scene {
            let skView = self.view as SKView
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            print("rendered level: ")
            println(level)
        }
    }

   

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    override func shouldAutorotate() -> Bool { return true }
    override func prefersStatusBarHidden() -> Bool { return true }
}
