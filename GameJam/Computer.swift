//
//  Computer.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Computer: Player {
    
    override init(view: SKView) {
        super.init(view: view)
        let num = arc4random() % 2
        if num == 0 {
            self.ability = Ability.Attacker
        } else if num == 1 {
            self.ability = Ability.Defender
        } else if num == 2 {
            self.ability = Ability.Miner
        }
    }
    
    func decide(view: SKView, enemy: Player, scene: SKScene) {
        if self.gold >= 40 {
            let attacker = Attacker(playerNumber: 2)
            
            self.attackers.append(attacker)
            self.attackableSprites.append(attacker)
            
            self.decrementGold(self.attackerCost)
            
            attacker.position = CGPointMake(wall.position.x - (Attacker(playerNumber: 2).frame.width * 1.5), wall.position.y)
            
            if self.ability == Ability.Attacker {
                attacker.attackPower *= 2
            }
            
            self.findTarget(attacker, enemySprites: enemy.attackableSprites)
            
            scene.addChild(attacker)
        }
    }
    
    override func findTarget(attacker: Attacker, enemySprites: Array<AttackableSprite>) {
        attacker.target = nil
        
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, attacker.position.x, attacker.position.y)
        
        for sprite in enemySprites {
            if sprite.isKindOfClass(Wall) {
                attacker.target = sprite as Wall
            } else if sprite.isKindOfClass(Castle) {
                attacker.target = sprite as Castle
            }
        }
        if (attacker.target != nil) {
            CGPathAddLineToPoint(path, nil, attacker.target.position.x + (attacker.frame.width * 1.5), attacker.target.position.y)
            
            var action = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 5)
            
            attacker.run()
            attacker.runAction(action, completion: {
                attacker.removeActionForKey("run")
                attacker.attack()
            })
        }
    }
}