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
    
    var timer: NSTimer!
    var goldTimer: NSTimer!
    
    var clock: Clock!
    var timerLabel: SKLabelNode!
    
    var player1: Player!
    var player2: Player!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.04, alpha: 1)
        
        clock = Clock()
        
        setupPlayers(view)
        createButtons(view)
        
        startTimer(view)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
        }
    }
    
    func createButtons(view: SKView) {
        let buttonSize = 50
        
        let attackerTex = SKTexture(imageNamed: "sword")
        let defenderTex = SKTexture(imageNamed: "shield")
        let minerTex    = SKTexture(imageNamed: "pick")
        
        let attackerButton = SKSpriteNode(texture: attackerTex, size: CGSize(width: buttonSize, height: buttonSize))
        let defenderButton = SKSpriteNode(texture: defenderTex, size: CGSize(width: buttonSize, height: buttonSize))
        let minerButton    = SKSpriteNode(texture: minerTex,    size: CGSize(width: buttonSize, height: buttonSize))
        
        var buttonsX = view.bounds.minX + (attackerButton.size.width/2)
        var buttonsY = view.bounds.minY + (attackerButton.size.height/2)
        attackerButton.position = CGPointMake(buttonsX, buttonsY)
        
        buttonsX += (defenderButton.size.width * 0.75)
        defenderButton.position = CGPointMake(buttonsX, buttonsY)
        
        buttonsX += (minerButton.size.width * 0.75)
        minerButton.position = CGPointMake(buttonsX, buttonsY)
        
        self.addChild(attackerButton)
        self.addChild(defenderButton)
        self.addChild(minerButton)
    }
    
    func setupPlayers(view: SKView) {
        /* Setup Players/Bases */
        player1 = Player()
        player1.castle.position = CGPointMake(player1.castle.size.height/2, view.bounds.midY)
        player1.castle.zRotation = CGFloat(M_PI_2)
        
        let xShift = player1.castle.size.height + (player1.castle.size.height/4)
        player1.wall.position = CGPointMake(xShift, view.bounds.midY)
        player1.wall.zRotation = CGFloat(M_PI_2)
        
        player2 = Player()
        player2.castle.position = CGPointMake(view.bounds.maxX-player2.castle.size.height/2, view.bounds.midY)
        player2.castle.zRotation = CGFloat(-M_PI_2)
        
        let xShift2 = view.bounds.maxX-(player2.castle.size.height + (player2.castle.size.height/4))
        player2.wall.position = CGPointMake(xShift2, view.bounds.midY)
        player2.wall.zRotation = CGFloat(-M_PI_2)
        
        self.addChild(player1.castle)
        self.addChild(player1.wall)
        self.addChild(player2.castle)
        self.addChild(player2.wall)
    }
    
    func incrementTimer() {
        clock.tick()
        timerLabel.text = clock.getTime()
    }
    
    func incrementGold() {
        player1.incrementGold()
        player2.incrementGold()
    }
    
    func startTimer(view: SKView) {
        println("HERE")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("incrementTimer"), userInfo: nil, repeats: true)
        goldTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("incrementGold"), userInfo: nil, repeats: true)
        
        timerLabel = SKLabelNode(text: clock.getTime())
        timerLabel.fontSize = 20
        timerLabel.position = CGPointMake(view.bounds.midX, view.bounds.maxY-(timerLabel.frame.height))

        self.addChild(timerLabel)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}