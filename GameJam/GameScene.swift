//
//  GameScene.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var viewController: GameViewController!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.04, alpha: 1)
        
        /* Setup Base */
        let castle = Castle()
        castle.position = CGPointMake(castle.size.height/2, view.bounds.midY)
        castle.zRotation = CGFloat(M_PI_2)
        
        let wall = Wall()
        let xShift = castle.size.height + (castle.size.height/4)
        wall.position = CGPointMake(xShift, view.bounds.midY)
        wall.zRotation = CGFloat(M_PI_2)
        
        let castle2 = Castle()
        castle2.position = CGPointMake(view.bounds.maxX-castle2.size.height/2, view.bounds.midY)
        castle2.zRotation = CGFloat(-M_PI_2)
        
        let wall2 = Wall()
        let xShift2 = view.bounds.maxX-(castle2.size.height + (castle2.size.height/4))
        wall2.position = CGPointMake(xShift2, view.bounds.midY)
        wall2.zRotation = CGFloat(-M_PI_2)
        
        self.addChild(castle)
        self.addChild(wall)
        self.addChild(castle2)
        self.addChild(wall2)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            /*let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)*/
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}