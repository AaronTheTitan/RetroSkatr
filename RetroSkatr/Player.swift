//
//  Player.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright © 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
  
  // Character setup
  var charPushFrames = [SKTexture]()
  var charCrashFrames = [SKTexture]()
  
  let CHAR_X_POS: CGFloat = 130
  let CHAR_Y_POS: CGFloat = 180
  var isJumping = false
  
  
  convenience init() {
    self.init(imageNamed: "push0")
    setupCharacter()
  }
  
  func setupCharacter() {
    
    for var x = 0; x < 12; x++ {
      charPushFrames.append(SKTexture(imageNamed: "push\(x)"))
    }
    
    for var x = 0; x < 9; x++ {
      charCrashFrames.append(SKTexture(imageNamed: "crash\(x)"))
    }
    
    self.position = CGPointMake(CHAR_X_POS, CHAR_Y_POS)
    self.zPosition = 10
    
    
    let frontColliderSize = CGSizeMake(5, self.size.height * 0.80)
    let frontCollider = SKPhysicsBody(rectangleOfSize: frontColliderSize, center: CGPointMake(25, 0))
    
    let bottomColliderSize = CGSizeMake(self.size.width / 2, 5)
    let bottomCollider = SKPhysicsBody(rectangleOfSize: bottomColliderSize, center: CGPointMake(0, -(self.size.height / 2) + 5))
    
    self.physicsBody = SKPhysicsBody(bodies: [frontCollider, bottomCollider])
    
    self.physicsBody?.restitution = 0
    self.physicsBody?.linearDamping = 0.1
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.mass = 0.1
    self.physicsBody?.dynamic = true
    
    self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
    self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
    
    playPushAnim()
  }
  
  func jump() {
    if isJumping == false {
      runAction(SKAction.playSoundFileNamed("sfxOllie.wav", waitForCompletion: false))
      isJumping = true
      self.physicsBody?.applyImpulse(CGVectorMake(0.0, 60))
    }
  }
  
  func playPushAnim() {
    removeAllActions()
    self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(charPushFrames, timePerFrame: 0.1)))
  }
  
  func playCrashAnim() {
    removeAllActions()
    self.runAction(SKAction.animateWithTextures(charCrashFrames, timePerFrame: 0.04))
  }
  
  
  
  override func update() {
    if isJumping {
      if floor(self.physicsBody!.velocity.dy) == 0 {
        isJumping = false
      }
    }
  }
}
