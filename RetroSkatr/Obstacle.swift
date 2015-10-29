//
//  Obstacle.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class Obstacle: Moveable {
  
  override func startMoving() {
    super.startMoving()
    self.initPhysics()
  }
  

  func initPhysics() {
    physicsBody?.dynamic = false

    
  }
}
