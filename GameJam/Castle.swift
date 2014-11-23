//
//  Castle.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/21/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Castle: SKSpriteNode {
    
    var healthBar: HealthBar!
    
    var maxHitPoints: Float = 500
    var hitPoints: Float = 500
    
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "castle")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 100, height: 75))
        healthBar = HealthBar(view: view)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func incrementHealth(value: Float) {
        hitPoints += value
        healthBar.setHealth(hitPoints / maxHitPoints)
    }
    
    func decrementHealth(value: Float) {
        hitPoints -= value
        healthBar.setHealth(hitPoints / maxHitPoints)
        if hitPoints <= 0 {
            healthBar.removeFromParent()
            self.removeFromParent()
        }
    }
}