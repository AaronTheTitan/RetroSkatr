//
//  Building.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class Building: Moveable {
  
  convenience init() {
    self.init(imageNamed: "building\(arc4random_uniform(8))")
    self.anchorPoint = CGPointMake(0.5, 0)
    self.yPos = 200
    self.zPosition = 4
  }
  
  override func didExceedBounds() {
    super.didExceedBounds()
    self.texture = SKTexture(imageNamed: "building\(arc4random_uniform(8))")
  }
}
