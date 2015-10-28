//
//  GameScene.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  // Scenery Setup
  let ASP_PIECES = 15
  let GROUND_SPEED: CGFloat = 8.5
  let GROUND_X_RESET: CGFloat = -150
  var moveGroundAction: SKAction!
  var moveGroundActionForever: SKAction!
  var asphaltPieces = [SKSpriteNode]()
  
  // Character setup
  var charPushFrames = [SKTexture]()
  let CHAR_X_POS: CGFloat = 130
  let CHAR_Y_POS: CGFloat = 180
  var character: SKSpriteNode!
  var isJumping = false
  
  override func didMoveToView(view: SKView) {
    
    setupBackground()
    setupGround()
    setupCharacter()
    
    let tap = UITapGestureRecognizer(target: self, action: "jump:")
    tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
    self.view?.addGestureRecognizer(tap)
    
  }
  
  func setupBackground() {
    
    let bg = SKSpriteNode(imageNamed: "bg1")
    bg.position = CGPointMake(517, 400)
    bg.zPosition = 3
    addChild(bg)
    
    let bg2 = SKSpriteNode(imageNamed: "bg2")
    bg2.position = CGPointMake(517, 450)
    bg2.zPosition = 2
    addChild(bg2)
    
    let bg3 = SKSpriteNode(imageNamed: "bg3")
    bg3.position = CGPointMake(517, 500)
    bg3.zPosition = 1
    addChild(bg3)
  }
  
  func setupGround() {
    
    moveGroundAction = SKAction.moveByX(-GROUND_SPEED, y: 0, duration: 0.02)
    moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
    
    for var x = 0; x < ASP_PIECES; x++ {
      let asp = SKSpriteNode(imageNamed: "asphalt")
//      asp.zPosition = 4;
      asphaltPieces.append(asp)
      
      
      if x == 0 {
        let start = CGPointMake(0, 144)
        asp.position = start
      } else {
        asp.position = CGPointMake(asp.size.width + asphaltPieces[x - 1].position.x, asphaltPieces[x - 1].position.y)
      }
      
      asp.runAction(moveGroundActionForever)
      
      addChild(asp)
      
    }
    
  }
  
  func groundMovement() {

    for var x = 0; x < asphaltPieces.count; x++ {
      if asphaltPieces[x].position.x <= GROUND_X_RESET {
        
        var index: Int!
        
        if x == 0 {
          index = asphaltPieces.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPointMake(asphaltPieces[index].position.x + asphaltPieces[x].size.width, asphaltPieces[x].position.y)
        asphaltPieces[x].position = newPos
      }
    }
  }
  
  func setupCharacter() {
    
    for var x = 0; x < 12; x++ {
      charPushFrames.append(SKTexture(imageNamed: "push\(x)"))
    }
    
    character = SKSpriteNode(texture: charPushFrames[0])
    addChild(character)
    
    character.position = CGPointMake(CHAR_X_POS, CHAR_Y_POS)
    character.zPosition = 10
    
    character.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(charPushFrames, timePerFrame: 0.1)))
    
    character.physicsBody = SKPhysicsBody(rectangleOfSize: character.size)
    character.physicsBody?.restitution = 0
    character.physicsBody?.linearDamping = 0.1
    character.physicsBody?.allowsRotation = false
    character.physicsBody?.mass = 0.1
    character.physicsBody?.dynamic = false
    physicsWorld.gravity = CGVectorMake(0.0, -10) /// only active if dynamic is set to true...or so i think
  }
  
  func jump(gesture: UITapGestureRecognizer) {
    
    if isJumping == false {
      isJumping = true
      character.physicsBody?.dynamic = true
      character.physicsBody?.applyImpulse(CGVectorMake(0.0, 60))
    }
    
    
  }
  
  
  override func update(currentTime: CFTimeInterval) {
    groundMovement()
    
    if ceil(character.position.y) < CHAR_Y_POS {
      character.physicsBody?.dynamic = false
      character.position = CGPointMake(CHAR_X_POS, CHAR_Y_POS)
      isJumping = false
    }
  }
}






