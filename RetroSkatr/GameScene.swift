//
//  GameScene.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        setupBackground()
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
  
  func setupBackground() {
    let bg = SKSpriteNode(imageNamed: "bg1")
    bg.position = CGPointMake(517, 400)
    addChild(bg)
    
    let bg2 = SKSpriteNode(imageNamed: "bg2")
    bg2.position = CGPointMake(517, 450)
    
  }
}
