//
//  AttackableSprite.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class AttackableSprite: SKSpriteNode {
    
    var healthBar: HealthBar!
    
    var maxHitPoints: Float = 0.0
    var hitPoints: Float = 0.0
    
    var destroyed: Bool = false
    
    func incrementHealth(value: Float) {
        hitPoints += value
        healthBar.setHealth(hitPoints / maxHitPoints)
    }
    
    func decrementHealth(value: Float) {
        hitPoints -= value
        healthBar.setHealth(hitPoints / maxHitPoints)
        if hitPoints <= 0 {
            destroyed = true
            healthBar.removeFromParent()
            self.removeFromParent()
        }
    }
}