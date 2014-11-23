//
//  Miner.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Miner: SKSpriteNode {
    
    var health = 100
    
    override init() {
        let texture = SKTexture(imageNamed: "worker_walk1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 25, height: 30))
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func walk() {
        let images = fillImagesArray()
        
        let runAnimation = SKAction.animateWithTextures(images, timePerFrame: 0.345)
        
        let repeatAnim = SKAction.repeatActionForever(runAnimation)
        
        self.runAction(repeatAnim, withKey: "walk")
    }
    
    func fillImagesArray() -> Array<SKTexture> {
        var images: Array<SKTexture> = []
        for i in 1...8 {
            let imgName = "worker_walk\(i)"
            let tex = SKTexture(imageNamed: imgName)
            images.append(tex)
        }
        return images
    }
    
    func incrementHealth(value: Int) {
        health += value
    }
    
    func decrementHealth(value: Int) {
        health -= value
    }
}