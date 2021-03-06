//
//  DemoScene.swift
//  Jumper
//
//  Created by Jenna Raderstrong on 3/16/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import AVFoundation
import SpriteKit

class DemoLevel: SKScene, SKPhysicsContactDelegate {
    //private var player: SKSpriteNode!

    //var p: Player = Player()
    var player = SKSpriteNode(imageNamed: Player().fileName)
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToView(view: SKView) {
        player.position = CGPoint(x: 0.5, y: 0.5)
        addChild(player)
    }
}