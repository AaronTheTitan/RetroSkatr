//
//  GameScene.swift
//  RetroSkatr
//
//  Created by Aaron Bradley on 10/28/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  // Scenery Setup
  let ASP_PIECES = 15
  let SIDEWALK_PIECES = 24
  
  let GROUND_X_RESET: CGFloat = -150
  let BG_X_RESET: CGFloat = -912.0
  
  var moveGroundAction: SKAction!
  var moveGroundActionForever: SKAction!
  var asphaltPieces = [SKSpriteNode]()
  var sidewalkPieces = [SKSpriteNode]()
  
  var farBG = [SKSpriteNode]()
  var midBG = [SKSpriteNode]()
  var frontBG = [SKSpriteNode]()
  
  var backgroundActions = [SKAction]()
  var buildings = [SKSpriteNode]()
  var obstacles = [SKSpriteNode]()
  
  var player: Player!
  var musicPlayer: AVAudioPlayer!
  
  override func didMoveToView(view: SKView) {
    
    setupBackground()
    setupGround()
    
    let tap = UITapGestureRecognizer(target: self, action: "tapped:")
    tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
    self.view?.addGestureRecognizer(tap)
    
    physicsWorld.gravity = CGVectorMake(0.0, -10) /// only active if dynamic is set to true...or so i think
    physicsWorld.contactDelegate = self
    
    player = Player()
    addChild(player)
    
    
    let dumpster = Dumpster()
    addChild(dumpster)
    self.obstacles.append(dumpster)
    
    let dumpsterTop = DumpsterTop()
    addChild(dumpsterTop)
    dumpsterTop.position = CGPointMake(dumpster.position.x, dumpster.position.y + 50)
    obstacles.append(dumpsterTop)
    
    dumpsterTop.startMoving()
    dumpster.startMoving()
    
    for var x = 0; x < 3; x++ {
      let wait = SKAction.waitForDuration(2.0 * Double(x))
      self.runAction(wait, completion: { () -> Void in
        let building = Building()
        self.buildings.append(building)
        self.addChild(building)
        building.startMoving()
      })
    }
    
    playLevelMusic()
  }
  
  func playLevelMusic() {
    
    let levelMusicURL = NSBundle.mainBundle().URLForResource("musicMain", withExtension: "wav")!
    
    do {
      musicPlayer = try AVAudioPlayer(contentsOfURL: levelMusicURL)
      musicPlayer.numberOfLoops = -1
      musicPlayer.prepareToPlay()
      musicPlayer.play()
    } catch {
      
    }
  }
  
  func setupBackground() {
    
    var action: SKAction!
    
    for var x = 0; x < 3; x++ {
      let bg = SKSpriteNode(imageNamed: "bg1")
      bg.position = CGPointMake(CGFloat(x) * bg.size.width, 400)
      bg.zPosition = 3
      frontBG.append(bg)
      action = SKAction.repeatActionForever(SKAction.moveByX(-2.0, y: 0, duration: 0.02))
      bg.runAction(action)
      backgroundActions.append(action)
      addChild(bg)
      
      let bg2 = SKSpriteNode(imageNamed: "bg2")
      bg2.position = CGPointMake(CGFloat(x) * bg2.size.width, 450)
      bg2.zPosition = 2
      midBG.append(bg2)
      action = SKAction.repeatActionForever(SKAction.moveByX(-1.0, y: 0, duration: 0.02))
      bg2.runAction(action)
      backgroundActions.append(action)
      addChild(bg2)
      
      let bg3 = SKSpriteNode(imageNamed: "bg3")
      bg3.position = CGPointMake(CGFloat(x) * bg3.size.width, 500)
      bg3.zPosition = 1
      farBG.append(bg3)
      action = SKAction.repeatActionForever(SKAction.moveByX(-0.5, y: 0, duration: 0.02))
      bg3.runAction(action)
      backgroundActions.append(action)
      addChild(bg3)
      
    }
    
  }
  
  func setupGround() {
    
    moveGroundAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
    moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
    
    for var x = 0; x < ASP_PIECES; x++ {
      let asp = SKSpriteNode(imageNamed: "asphalt")
      asp.zPosition = 4;
      
      let collider = SKPhysicsBody(rectangleOfSize: CGSizeMake(asp.size.width, 5), center: CGPointMake(0, -20))
      collider.dynamic = false
      
      asp.physicsBody = collider
      
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
    
    
    // refactor so i don't duplicate
    
    for var x = 0; x < SIDEWALK_PIECES; x++ {
      let piece = SKSpriteNode(imageNamed: "sidewalk")
      sidewalkPieces.append(piece)
      
      if x == 0 {
        let start = CGPointMake(0, 190)
        piece.position = start
      } else {
        piece.position = CGPointMake(piece.size.width + sidewalkPieces[x - 1].position.x, sidewalkPieces[x - 1].position.y)
      }
     
      piece.zPosition = 5
      piece.runAction(moveGroundActionForever)
      addChild(piece)
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
    
    // refactor so i don't duplicate
    for var x = 0; x < sidewalkPieces.count; x++ {
      if sidewalkPieces[x].position.x <= GROUND_X_RESET {
        
        var index: Int!
        
        if x == 0 {
          index = sidewalkPieces.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPointMake(sidewalkPieces[index].position.x + sidewalkPieces[x].size.width, sidewalkPieces[x].position.y)
        sidewalkPieces[x].position = newPos
      }
    }
    
    for var x = 0; x < 3; x++ {
      
      if farBG[x].position.x <= BG_X_RESET {
        var index: Int!
        
        if x == 0 {
          index = farBG.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPointMake(farBG[index].position.x + farBG[x].size.width, farBG[x].position.y)
        farBG[x].position = newPos
      }
      
      
      
      if midBG[x].position.x <= BG_X_RESET {
        var index: Int!
        
        if x == 0 {
          index = midBG.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPointMake(midBG[index].position.x + midBG[x].size.width, midBG[x].position.y)
        midBG[x].position = newPos
      }
      
      
      if frontBG[x].position.x <= BG_X_RESET {
        var index: Int!
        
        if x == 0 {
          index = frontBG.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPointMake(frontBG[index].position.x + frontBG[x].size.width, frontBG[x].position.y)
        frontBG[x].position = newPos
      }
      
      
    }
  }
  

  func tapped(gesture: UITapGestureRecognizer) {
    player.jump()
  }
  
  
  override func update(currentTime: CFTimeInterval) {
    groundMovement()
    
    for child in children {
      child.update()
    }
  }
  
  
  func didBeginContact(contact: SKPhysicsContact) {
    
    if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
      self.removeAllActions()
      musicPlayer.stop()
      
      runAction(SKAction.playSoundFileNamed("sfxGameOver.wav", waitForCompletion: false))
      
      player.playCrashAnim()
      
      for node in asphaltPieces {
        node.removeAllActions()
      }
      
      for node in sidewalkPieces {
        node.removeAllActions()
      }
      
      for var x = 0; x < 3; x++ {
        farBG[x].removeAllActions()
        midBG[x].removeAllActions()
        frontBG[x].removeAllActions()
      }
      
      for obs in obstacles {
        obs.removeAllActions()
      }
      
      for bld in buildings {
        bld.removeAllActions()
      }
      
    }
  }
}






