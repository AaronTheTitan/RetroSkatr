//
//  Movable.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class Moveable: SKSpriteNode {
  
  static let RESET_X_POSITION: CGFloat = -800
  static let START_X_POSITION: CGFloat = 1800
  
  var yPos: CGFloat = 0
  
  var moveAction: SKAction!
  var moveForever: SKAction!
  
  func startMoving() {
    position = CGPointMake(Moveable.START_X_POSITION, yPos)
    
    moveAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
    moveForever = SKAction.repeatActionForever(moveAction)
    
    zPosition = 7
    runAction(moveForever)
    
  }
  
  override func update() {
    if position.x <= Moveable.RESET_X_POSITION {
      didExceedBounds()
    }
  }
  
  func didExceedBounds() {
    position = CGPointMake(Moveable.START_X_POSITION, position.y)
  }
  
}
