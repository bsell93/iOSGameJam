//
//  HealthBar.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class HealthBar: SKSpriteNode {

    var textures: Dictionary<Int,SKTexture> = Dictionary()
    
    var health: Float = 100
    
    init(view: SKView) {
        let texture = SKTexture(imageNamed: "health_100")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 50, height: 10))
        loadTextures()
        self.position = CGPointMake(view.bounds.midX, view.bounds.midY)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadTextures() {
        textures[1] = SKTexture(imageNamed: "health_01")
        for var i=5; i <= 100; i+=5 {
            let imgName = String(format: "health_%02d", i)
            let tex = SKTexture(imageNamed: imgName)
            textures[i] = tex
        }
    }
    
    func setHealth(value: Float) {
        health = value * 100
        if health == 100 {
            self.texture = textures[100]
        } else if health >= 95 {
            self.texture = textures[95]
        } else if health >= 90 {
            self.texture = textures[90]
        } else if health >= 85 {
            self.texture = textures[85]
        } else if health >= 80 {
            self.texture = textures[80]
        } else if health >= 75 {
            self.texture = textures[75]
        } else if health >= 70 {
            self.texture = textures[70]
        } else if health >= 65 {
            self.texture = textures[65]
        } else if health >= 60 {
            self.texture = textures[60]
        } else if health >= 55 {
            self.texture = textures[55]
        } else if health >= 50 {
            self.texture = textures[50]
        } else if health >= 45 {
            self.texture = textures[45]
        } else if health >= 40 {
            self.texture = textures[40]
        } else if health >= 35 {
            self.texture = textures[35]
        } else if health >= 30 {
            self.texture = textures[30]
        } else if health >= 25 {
            self.texture = textures[25]
        } else if health >= 20 {
            self.texture = textures[20]
        } else if health >= 15 {
            self.texture = textures[15]
        } else if health >= 10 {
            self.texture = textures[10]
        } else if health >= 5 {
            self.texture = textures[5]
        } else {
            self.texture = textures[1]
        }
    }
}