//
//  Test.swift
//  Jumper
//
//  Created by Dillon Drenzek on 2/19/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

//import SpriteKit
////
////  DemoScene.swift
////  Jumper
////
////  Created by Jenna Raderstrong on 3/16/15.
////  Copyright (c) 2015 OOGroup. All rights reserved.
////
//
//import AVFoundation
//import SpriteKit
//
//

import AVFoundation
import SpriteKit



class TestScene: SKScene {
    
    // These are instance variables
    // let defines constants
    // var defines variables

    var sprite = SKSpriteNode(imageNamed: "kitten.jpg")
    
    var location = CGPoint(x: 100.0, y: 100.0)
    
    // Function definition
    override func didMoveToView(view: SKView) {
        
        self.sprite.xScale = 0.5
        self.sprite.yScale = 0.5
        
        // Add sprite to a view
        self.addChild(self.sprite)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            
            self.location = location

        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.sprite.position = self.location
    }
}
//
//class TestScene: SKScene {
//    
//    // These are instance variables
//    // let defines constants
//    // var defines variables
//    var sprite = SKSpriteNode(imageNamed: "kitten.jpg")
//    var location = CGPoint(x: 0.0, y: 0.0)
//    
//    // Function definition
//    override func didMoveToView(view: SKView) {
//        
//        self.sprite.xScale = 0.25
//        self.sprite.yScale = 0.25
//        
//        // Add sprite to a view
//        self.addChild(self.sprite)
//    }
//    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            
//            self.location = location
//
//        }
//    }
//    
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//        self.sprite.position = self.location
//    }
//}
