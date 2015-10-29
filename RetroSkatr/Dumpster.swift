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
    let topCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * 0.80, 5), center: CGPointMake(0, self.size.height / 2 - 7))
    physicsBody = SKPhysicsBody(bodies: [frontCollider, topCollider])
    super.initPhysics()
    
  }
}
