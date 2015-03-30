//
//  Scene.swift
//  Jumper
//
//  Created by Dillon Drenzek on 3/29/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import AVFoundation
import SpriteKit

class Scene: SKScene, SKPhysicsContactDelegate {
    
    let PlayerCategoryName = "player"
    let BottomCategoryName = "bottom"
    let WallCategoryName = "wall"
    
    let PlayerCategory  : UInt32 = 0x1 << 0
    let BottomCategory  : UInt32 = 0x1 << 1
    let WallCategory    : UInt32 = 0x1 << 2
    
    var player: SKSpriteNode?
    
    
    /* Init Methods */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        
        // Create a physics body that borders the screen (minus the 10px ground)
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        
        let player = childNodeWithName(PlayerCategoryName) as SKSpriteNode!
        let wall = childNodeWithName(WallCategoryName) as SKSpriteNode!
        let bottom = childNodeWithName(BottomCategoryName) as SKSpriteNode!
        
        
        wall.physicsBody!.categoryBitMask = WallCategory
        player.physicsBody!.categoryBitMask = PlayerCategory
        bottom.physicsBody!.categoryBitMask = BottomCategory
        
        player.physicsBody!.contactTestBitMask = WallCategory | BottomCategory
        
        physicsWorld.contactDelegate = self
        
//        player.physicsBody!.applyImpulse(CGVector(dx: 200, dy: 200))

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == PlayerCategoryName {
                let player = childNodeWithName(PlayerCategoryName) as SKSpriteNode!
                
                let vx = CGFloat(arc4random() % 2000) - 1000
                let vy = CGFloat(arc4random() % 1000)
                
                
                player.physicsBody!.applyImpulse(CGVector(dx: vx, dy: vy))
            }
        }
    }
    
    
    
    /* SKPhysicsContactDelegate */
    func didBeginContact(contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between ball and bottom
        if firstBody.categoryBitMask == PlayerCategory && secondBody.categoryBitMask == WallCategory {
            println("Hit wall.")
        } else if firstBody.categoryBitMask == PlayerCategory && secondBody.categoryBitMask == BottomCategory {
            println("Hit bottom.")
        }
    }
}