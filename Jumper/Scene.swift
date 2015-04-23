//
//  Scene.swift
//  Jumper
//
//  Created by Dillon Drenzek on 3/29/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import AVFoundation
import SpriteKit
import Darwin

protocol SceneDelegate {
    func goalReached()
}

class Scene: SKScene, SKPhysicsContactDelegate {
    
    var sceneDelegate: SceneDelegate?
    
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
    var xp: CGFloat = 0.0
    var yp: CGFloat = 0.0
    var xp2: CGFloat = 0.0
    var yp2: CGFloat = 0.0
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
        
        
        let player = childNodeWithName(PlayerCategoryName) as! SKSpriteNode!
        let wall = childNodeWithName(WallCategoryName) as! SKSpriteNode!
        let bottom = childNodeWithName(BottomCategoryName) as! SKSpriteNode!
        let goal = childNodeWithName(GoalCategoryName) as! SKSpriteNode!
        
        
        wall.physicsBody!.categoryBitMask = WallCategory
        player.physicsBody!.categoryBitMask = PlayerCategory
        bottom.physicsBody!.categoryBitMask = BottomCategory
        goal.physicsBody!.categoryBitMask = GoalCategory
        
        player.physicsBody!.contactTestBitMask = WallCategory | BottomCategory | GoalCategory
        
        physicsWorld.contactDelegate = self

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == PlayerCategoryName {
                let player = childNodeWithName(PlayerCategoryName) as! SKSpriteNode!
                
                pathToDraw = CGPathCreateMutable()
                CGPathMoveToPoint(pathToDraw, nil, touchLocation.x, touchLocation.y)
                CGPathAddLineToPoint(pathToDraw, nil, touchLocation.x+0.01, touchLocation.y+0.01)
                lineNode = SKShapeNode()
                lineNode.path = pathToDraw
                lineNode.lineWidth = 15
                lineNode.strokeColor = SKColor.redColor()
                addChild(lineNode)
                
                xi = touchLocation.x
                yi = touchLocation.y
                lock = 1
            }
        }
    }

    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        let player = childNodeWithName(PlayerCategoryName) as! SKSpriteNode!
        let vx = (touchLocation.x - xi)
        let vy = (touchLocation.y - yi)
        let actionMoveDone = SKAction.removeFromParent()
        lineNode.runAction(actionMoveDone)
        if lock == 1 {
            player.physicsBody!.applyImpulse(CGVector(dx: vx, dy: vy))
            lock = 0
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        pathToDraw = CGPathCreateMutable()
        CGPathMoveToPoint(pathToDraw, nil, xi, yi)
        CGPathAddLineToPoint(pathToDraw, nil, touchLocation.x, touchLocation.y)
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
                    testFinish()
                    break;
                default:
                    break;
            }
        }
    }
    
    func testFinish () {
        println("YOU WIN!")
        self.sceneDelegate?.goalReached()
    }
}