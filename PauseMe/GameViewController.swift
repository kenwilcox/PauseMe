//
//  GameViewController.swift
//  PauseMe
//
//  Created by Kenneth Wilcox on 1/12/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
  class func unarchiveFromFile(file : NSString) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
      guard let sceneData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe) else {
        return nil
      }
      //var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
      let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
}

class GameViewController: UIViewController {
  var paused = false
  var scene: SKScene?
  
  @IBOutlet weak var pauseButton: UIButton!
  
  @IBAction func touchPause(sender: AnyObject) {
    paused = !paused
    self.scene!.paused = paused
    if (paused) {
      pauseButton.setTitle("Paused", forState: .Normal)
    } else {
      pauseButton.setTitle("Pause", forState: .Normal)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
      // Configure the view.
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .AspectFill
      self.scene = scene
      skView.presentScene(scene)
    }
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return UIInterfaceOrientationMask.AllButUpsideDown
    } else {
      return UIInterfaceOrientationMask.All
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
