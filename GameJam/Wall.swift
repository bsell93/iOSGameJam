//
//  Wall.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: AttackableSprite {
    
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "wall")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 200, height: 100))
        
        self.maxHitPoints = 250
        self.hitPoints = 250
        
        self.healthBar = HealthBar(view: view)
    }
}