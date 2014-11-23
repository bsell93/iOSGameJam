//
//  Castle.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/21/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Castle: AttackableSprite {
    
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "castle")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 100, height: 75))
        
        self.maxHitPoints = 500
        self.hitPoints = 500
        
        self.healthBar = HealthBar(view: view)
    }
}