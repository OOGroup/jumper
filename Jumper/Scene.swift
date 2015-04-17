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
    let GoalCategoryName = "goal"
    
    let PlayerCategory  : UInt32 = 0x1 << 0
    let BottomCategory  : UInt32 = 0x1 << 1
    let WallCategory    : UInt32 = 0x1 << 2
    let GoalCategory    : UInt32 = 0x1 << 3
    
    var player: SKSpriteNode?
    var xi: CGFloat = 0.0
    var yi: CGFloat = 0.0
    var lock = 0
    
    lazy var lineNode: SKShapeNode = SKShapeNode()
    var pathToDraw: CGMutablePathRef = CGPathCreateMutable()
    
    
    
    /* Init Methods */
    required init?(coder aDecoder: NSCoder) {
        CGPathMoveToPoint(pathToDraw, nil, CGFloat(0.0), CGFloat(0.0))
        super.init(coder: aDecoder)
    }
    
    /* Did Move to View */
    override func didMoveToView(view: SKView) {
        
        // Create a physics body that borders the screen (minus the 10px ground)
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        
        let player = childNodeWithName(PlayerCategoryName) as SKSpriteNode!
        let wall = childNodeWithName(WallCategoryName) as SKSpriteNode!
        let bottom = childNodeWithName(BottomCategoryName) as SKSpriteNode!
        let goal = childNodeWithName(GoalCategoryName) as SKSpriteNode!
        
        
        wall.physicsBody!.categoryBitMask = WallCategory
        player.physicsBody!.categoryBitMask = PlayerCategory
        bottom.physicsBody!.categoryBitMask = BottomCategory
        goal.physicsBody!.categoryBitMask = GoalCategory
        
        player.physicsBody!.contactTestBitMask = WallCategory | BottomCategory | GoalCategory
        
        physicsWorld.contactDelegate = self

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == PlayerCategoryName {
                let player = childNodeWithName(PlayerCategoryName) as SKSpriteNode!
                
                // Random vector components
//                let vx = CGFloat(arc4random() % 2000) - 1000
//                let vy = CGFloat(arc4random() % 1000)
                
                //let vx = (player.frame.midX - touchLocation.x) * 20
                //let vy = (player.frame.midY - touchLocation.y) * 20
                
                pathToDraw = CGPathCreateMutable()
                CGPathMoveToPoint(pathToDraw, nil, touchLocation.x, touchLocation.y)
                lineNode = SKShapeNode()
                lineNode.path = pathToDraw
                //lineNode.lineWidth = 20
                lineNode.strokeColor = SKColor.redColor()
                addChild(lineNode)
                
                xi = touchLocation.x
                yi = touchLocation.y
                lock = 1
                // println("apply impulse to player: (\(vx), \(vy))")
                //player.physicsBody!.applyImpulse(CGVector(dx: vx, dy: vy))
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        let player = childNodeWithName(PlayerCategoryName) as SKSpriteNode!
        let vx = (touchLocation.x - xi)
        let vy = (touchLocation.y - yi)
        if lock == 1 {
            player.physicsBody!.applyImpulse(CGVector(dx: vx, dy: vy))
            lock = 0
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        //CGPathAddLineToPoint(pathToDraw, nil, touchLocation.x, touchLocation.y)
        CGPathMoveToPoint(pathToDraw, nil, touchLocation.x, touchLocation.y)
        lineNode.path = pathToDraw
    }
    
    
    /* SKPhysicsContactDelegate */
    func didBeginContact(contact: SKPhysicsContact) {
        
        // Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Collision Testing for Player
        if (firstBody.categoryBitMask == PlayerCategory) {
            switch secondBody.categoryBitMask {
                case WallCategory:
                    println("Hit wall.")
                    break;
                case BottomCategory:
                    println("Hit bottom.")
                    break;
                case GoalCategory:
                    println("YOU WIN!")
                    break;
                default:
                    break;
            }
        }
    }
}