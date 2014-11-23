//
//  Attacker.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Attacker: SKSpriteNode {
    
    var hitPoints = 100
    
    var target: SKSpriteNode!
    
    override init() {
        let texture = SKTexture(imageNamed: "warrior_run1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 25, height: 30))
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func run() {
        let images = fillImagesArray("run")
        
        let runAnimation = SKAction.animateWithTextures(images, timePerFrame: 0.3325)
        
        let repeatAnim = SKAction.repeatActionForever(runAnimation)
        
        self.runAction(repeatAnim, withKey: "run")
    }
    
    func attack() {
        let images = fillImagesArray("attack")
        
        let runAnimation = SKAction.animateWithTextures(images, timePerFrame: 0.2)
        
        let repeatAnim = SKAction.repeatActionForever(runAnimation)
        
        self.runAction(repeatAnim, withKey: "attack")
    }
    
    func fillImagesArray(action: String) -> Array<SKTexture> {
        var images: Array<SKTexture> = []
        for i in 1...6 {
            let imgName = "warrior_\(action)\(i)"
            let tex = SKTexture(imageNamed: imgName)
            images.append(tex)
        }
        return images
    }
    
    func incrementHealth(value: Int) {
        hitPoints += value
    }
    
    func decrementHealth(value: Int) {
        hitPoints -= value
    }
}