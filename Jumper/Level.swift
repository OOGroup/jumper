//
//  GameLevel.swift
//  Jumper
//
//  Created by Dillon Drenzek on 3/29/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import AVFoundation
import SpriteKit

protocol LevelDelegate {
    func levelDidComplete()
}

class Level: SceneDelegate {

    var sceneFile: NSString = ""
    var levelDelegate: LevelDelegate?
    var scene: Scene? {
        get {
            let sc: Scene? = Scene.unarchiveFromFile(self.sceneFile) as? Scene
            if (sc != nil) {
                sc?.sceneDelegate = self
                sc?.scaleMode = .AspectFill
            }
            return sc
        }
    }
    
    
    /* Init Methods */
    init(sceneFile: NSString) {
        self.sceneFile = sceneFile
    }
    init() {}
    
    /*
    *   Scene Delegate
    */
    func goalReached() {
        NSLog("goal reached!")
        self.levelDelegate?.levelDidComplete()
    }
}