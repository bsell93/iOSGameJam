//
//  GameViewController.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/21/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene(size: self.view.bounds.size)
        
        scene.viewController = self
        
        // Configure the view.
        skView = self.view as SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
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
