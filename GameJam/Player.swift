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
    var ability: String!
    
    var castle: Castle!
    var wall: Wall!
    var goldMine: GoldMine!
    
    var sprites: Array<SKSpriteNode> = []
    
    let attackerCost = 40
    let defenderCost = 30
    let minerCost = 55
    
    var view: SKView!
    
    init (view: SKView) {
        self.view = view
        
        ability = "None"
        
        castle = Castle(view: view)
        wall = Wall(view: view)
        goldMine = GoldMine()
        
        sprites = [castle, wall, wall.healthBar, castle.healthBar, goldMine]
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
        }
    }
    
    func incrementGold() {
        gold += 5 + (goldMine.workers * 5)
    }
    
    func decrementGold(value: Int) {
        gold -= value
    }
}