//
//  Defender.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Defender: SKSpriteNode {
    
    var health = 100
    
    override init() {
        let texture = SKTexture(imageNamed: "castle")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 100, height: 75))
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func incrementHealth(value: Int) {
        health += value
    }
    
    func decrementHealth(value: Int) {
        health -= value
    }
}