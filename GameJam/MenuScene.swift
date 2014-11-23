//
//  GameScene.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/21/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var beginLabel: SKLabelNode!
    var viewController: GameViewController!
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        beginLabel = SKLabelNode(text: "Begin")
        beginLabel.fontSize = 50;
        beginLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(beginLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let obj = nodeAtPoint(location)
            
            if (obj == beginLabel) {
                let ability = AbilityScene(size: viewController.view.bounds.size)
                ability.viewController = viewController
                viewController.skView.presentScene(ability)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
