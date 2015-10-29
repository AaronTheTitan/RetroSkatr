//
//  GameManager.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class GameManager {
  static let sharedInstance = GameManager()
  
  let MOVEMENT_SPEED: CGFloat = -8.5
  
  // Colliders
  let COLLIDER_OBSTACLE: UInt32 = 1 << 0
  let COLLIDER_PLAYER: UInt32 = 1 << 1
  let COLLIDER_RIDEABLE: UInt32 = 1 << 2

}