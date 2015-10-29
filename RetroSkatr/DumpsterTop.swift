//
//  DumpsterTop.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/29/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class DumpsterTop: Obstacle {
  convenience init() {
    self.init(color: UIColor.clearColor(), size: CGSizeMake(100, 2))
    self.yPos = 220
  }
  
  override func initPhysics() {
    physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
    zPosition = 6

    super.initPhysics()
  }
}
