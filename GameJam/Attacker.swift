//
//  Attacker.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class Attacker: AttackableSprite {
    
    var attackTimer: NSTimer!
    
    var target: AttackableSprite!
    
    var playerNum = 0
    
    var attackPower: Float = 5
    
    init(playerNumber: Int) {
        playerNum = playerNumber
        var texture: SKTexture = SKTexture()
        if playerNumber == 1 {
            texture = SKTexture(imageNamed: "warrior_run1")
        } else {
            texture = SKTexture(imageNamed: "warrior1_run1")
        }
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 25, height: 30))
        self.maxHitPoints = 20
        self.hitPoints = 20
    }
    
    func nearTarget() -> Bool {
        if (target != nil) {
            return target.frame.intersects(self.frame)
        } else {
            return false
        }
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
    
    func idle() {
        if playerNum == 1 {
            self.texture = SKTexture(imageNamed: "warrior_attack1")
        } else {
            self.texture = SKTexture(imageNamed: "warrior1_attack1")
        }
    }
    
    func fillImagesArray(action: String) -> Array<SKTexture> {
        var images: Array<SKTexture> = []
        for i in 1...6 {
            var imgName: String = ""
            if playerNum == 1 {
                imgName = "warrior_\(action)\(i)"
            } else {
                imgName = "warrior1_\(action)\(i)"
            }
            let tex = SKTexture(imageNamed: imgName)
            images.append(tex)
        }
        return images
    }
}