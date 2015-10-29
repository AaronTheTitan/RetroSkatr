//
//  Dumpster.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class Dumpster: Obstacle {
  
  convenience init() {
    self.init(imageNamed: "dumpster")
    self.yPos = 180
  }
  
  override func initPhysics() {
    
    let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(5, self.size.height), center: CGPointMake(-(self.size.width / 2), 0))
    
    frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
    frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER

    physicsBody = frontCollider
    zPosition = 6
    super.initPhysics()
    
  }
}
