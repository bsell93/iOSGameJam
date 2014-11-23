//
//  Player.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit


class Player: NSObject {
    
    var gold = 55
    var units = 0
    var ability: Ability!
    
    var startingPoint: CGPoint!
    
    var castle: Castle!
    var wall: Wall!
    var goldMine: GoldMine!
    
    var sprites: Array<SKSpriteNode> = []
    var attackableSprites: Array<AttackableSprite> = []
    var attackers: Array<Attacker> = []
    
    let attackerCost = 40
    let defenderCost = 30
    let minerCost = 55
    
    var minerMultiplier = 1
    
    var view: SKView!
    
    init (view: SKView) {
        self.view = view
        
        castle = Castle(view: view)
        wall = Wall(view: view)
        goldMine = GoldMine()
        
        sprites = [castle, wall, wall.healthBar, castle.healthBar, goldMine]
        attackableSprites = [castle, wall]
    }
    
    func setPosition(side: String) {
        if side == "left" {
            castle.position = CGPointMake(castle.size.height / 2, view.bounds.midY)
            castle.zRotation = CGFloat(M_PI_2)
            
            castle.healthBar.position = CGPointMake(castle.position.x, castle.position.y)
            castle.healthBar.zRotation = CGFloat(M_PI_2)
            
            let xShift = castle.size.height + (castle.size.height / 4)
            wall.position = CGPointMake(xShift, view.bounds.midY)
            wall.zRotation = CGFloat(M_PI_2)
            
            wall.healthBar.position = CGPointMake(wall.position.x, wall.position.y)
            wall.healthBar.zRotation = CGFloat(M_PI_2)
            
            goldMine.position = CGPointMake(view.bounds.midX - (goldMine.size.width * 2), view.bounds.midY + (goldMine.size.height * 2))
            
            startingPoint = CGPointMake(wall.position.x + (Attacker(playerNumber: 1).frame.width * 1.5), wall.position.y)
        } else if side == "right" {
            castle.position = CGPointMake(view.bounds.maxX - (castle.size.height / 2), view.bounds.midY)
            castle.zRotation = CGFloat(-M_PI_2)
            
            castle.healthBar.position = CGPointMake(castle.position.x, castle.position.y)
            castle.healthBar.zRotation = CGFloat(-M_PI_2)
            
            let xShift = view.bounds.maxX-(castle.size.height + (castle.size.height / 4))
            wall.position = CGPointMake(xShift, view.bounds.midY)
            wall.zRotation = CGFloat(-M_PI_2)
        
            wall.healthBar.position = CGPointMake(wall.position.x, wall.position.y)
            wall.healthBar.zRotation = CGFloat(-M_PI_2)
            
            goldMine.position = CGPointMake(view.bounds.midX + (goldMine.size.width * 2 ), view.bounds.midY - (goldMine.size.height * 2))
            
            startingPoint = CGPointMake(wall.position.x - (Attacker(playerNumber: 2).frame.width * 1.5), wall.position.y)
        }
    }
    
    func findTarget(attacker: Attacker, enemySprites: Array<AttackableSprite>) {
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
            CGPathAddLineToPoint(path, nil, attacker.target.position.x - (attacker.frame.width * 1.5), attacker.target.position.y)
            
            var action = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 5)
            
            attacker.run()
            attacker.runAction(action, completion: {
                attacker.removeActionForKey("run")
                attacker.attack()
            })
        }
    }
    
    func incrementGold() {
        gold += 5 + ((goldMine.workers * 5) * minerMultiplier)
    }
    
    func decrementGold(value: Int) {
        gold -= value
    }
}