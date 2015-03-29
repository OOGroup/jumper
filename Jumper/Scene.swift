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
    //var p: Player = Player()
    var player = SKSpriteNode(imageNamed: Player().fileName)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //let player = SKSpriteNode(imageNamed: p.fileName)
        //        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        player.position = CGPoint(x: 0.5, y: 0.5)
        addChild(player)
    }
}