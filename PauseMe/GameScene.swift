//
//  GameScene.swift
//  PauseMe
//
//  Created by Kenneth Wilcox on 1/12/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    myLabel.text = "Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
    
    self.addChild(myLabel)
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
    
    // if we want a new spaceship - don't pause the scene
    self.paused = false
    
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      
      let sprite = SKSpriteNode(imageNamed:"Spaceship")
      
      sprite.xScale = 0.5
      sprite.yScale = 0.5
      sprite.position = location
      
      let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
      
      sprite.runAction(SKAction.repeatActionForever(action))
      
      self.addChild(sprite)
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
