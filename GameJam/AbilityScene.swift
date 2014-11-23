//
//  AbilityScene.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class AbilityScene: SKScene {
    
    var attackerLabel: SKLabelNode!
    var defenderLabel: SKLabelNode!
    var minerLabel: SKLabelNode!
    
    var viewController: GameViewController!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        let title = SKLabelNode(text: "Choose Secret")
        
        attackerLabel = SKLabelNode(text: "Attacker")
        attackerLabel.fontSize = 30;
        attackerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + (attackerLabel.frame.size.height * 2));
        
        defenderLabel = SKLabelNode(text: "Defender")
        defenderLabel.fontSize = 30;
        defenderLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        minerLabel = SKLabelNode(text: "Miner")
        minerLabel.fontSize = 30;
        minerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - (minerLabel.frame.size.height * 2));
        
        self.addChild(attackerLabel)
        self.addChild(defenderLabel)
        self.addChild(minerLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let obj = nodeAtPoint(location)
            
            if (obj == attackerLabel) {
                let game = GameScene(size: viewController.view.bounds.size)
                
                game.viewController = viewController
                game.p1Ability = Ability.Attacker
                
                viewController.skView.presentScene(game)
            } else if (obj == defenderLabel) {
                let game = GameScene(size: viewController.view.bounds.size)
                
                game.viewController = viewController
                game.p1Ability = Ability.Defender
                
                viewController.skView.presentScene(game)
            } else if (obj == minerLabel) {
                let game = GameScene(size: viewController.view.bounds.size)
                
                game.viewController = viewController
                game.p1Ability = Ability.Miner
                
                viewController.skView.presentScene(game)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

enum Ability {
    case Attacker
    case Defender
    case Miner
}