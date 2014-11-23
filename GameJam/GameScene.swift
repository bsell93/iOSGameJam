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
    
    var p1GoldLabel: SKLabelNode!
    var p2GoldLabel: SKLabelNode!
    
    var p1NumMinersLabel: SKLabelNode!
    
    var attackerButton: SKSpriteNode!
    var defenderButton: SKSpriteNode!
    var minerButton: SKSpriteNode!
    
    let labelFontSize: CGFloat = 10
    
    var p1StartingPosition: CGPoint!
    var p2StartingPosition: CGPoint!
    
    var p1AttackerPath: CGMutablePathRef!
    var p1MinerPath: CGMutablePathRef!
    
    var p2AttackerPath: CGMutablePathRef!
    var p2MinerPath: CGMutablePathRef!
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAttackerPaths() {
        /* Attacker Path */
        p1AttackerPath = CGPathCreateMutable()
        p2AttackerPath = CGPathCreateMutable()
        
        CGPathMoveToPoint(p1AttackerPath, nil, p1StartingPosition.x, p1StartingPosition.y)
        CGPathMoveToPoint(p2AttackerPath, nil, p2StartingPosition.x, p2StartingPosition.y)
        
        CGPathAddLineToPoint(p1AttackerPath, nil, p2StartingPosition.x, p2StartingPosition.y)
        CGPathAddLineToPoint(p2AttackerPath, nil, p1StartingPosition.x, p1StartingPosition.y)
        
        /* Miner Path */
        p1MinerPath = CGPathCreateMutable()
        p2MinerPath = CGPathCreateMutable()
        
        CGPathMoveToPoint(p1MinerPath, nil, p1StartingPosition.x, p1StartingPosition.y)
        CGPathMoveToPoint(p2MinerPath, nil, p2StartingPosition.x, p2StartingPosition.y)
        
        CGPathAddLineToPoint(p1MinerPath, nil, player1.goldMine.position.x, player1.goldMine.position.y - player1.goldMine.size.height)
        CGPathAddLineToPoint(p2MinerPath, nil, player2.goldMine.position.x, player2.goldMine.position.y + player2.goldMine.size.height)
    }
    
    func createGoldLabels(view: SKView) {
        p1GoldLabel = SKLabelNode(text: "Gold: \(player1.gold)")
        p2GoldLabel = SKLabelNode(text: "Gold: \(player2.gold)")
        
        p1GoldLabel.fontSize = labelFontSize * 2
        p2GoldLabel.fontSize = labelFontSize * 2
        
        p1GoldLabel.position = CGPointMake(view.bounds.minX + (p2GoldLabel.frame.width / 2), view.bounds.maxY - p1GoldLabel.frame.height)
        p2GoldLabel.position = CGPointMake(view.bounds.maxX - (p2GoldLabel.frame.width / 2), view.bounds.maxY - p2GoldLabel.frame.height)
        
        self.addChild(p1GoldLabel)
        //self.addChild(p2GoldLabel)
    }
    
    func createButtons(view: SKView) {
        
        let buttonSize = 50
        
        let attackerTex = SKTexture(imageNamed: "sword")
        let attackerCostLabel = SKLabelNode(text: "\(player1.attackerCost)G")
        
        let defenderTex = SKTexture(imageNamed: "shield")
        let defenderCostLabel = SKLabelNode(text: "\(player1.defenderCost)G")
        
        let minerTex    = SKTexture(imageNamed: "pick")
        let minerCostLabel = SKLabelNode(text: "\(player1.minerCost)G")
        
        attackerButton = SKSpriteNode(texture: attackerTex, size: CGSize(width: buttonSize, height: buttonSize))
        attackerCostLabel.fontSize = labelFontSize
        
        defenderButton = SKSpriteNode(texture: defenderTex, size: CGSize(width: buttonSize, height: buttonSize))
        defenderCostLabel.fontSize = labelFontSize
        
        minerButton    = SKSpriteNode(texture: minerTex,    size: CGSize(width: buttonSize, height: buttonSize))
        minerCostLabel.fontSize = labelFontSize
        
        var buttonsX = view.bounds.minX + (attackerButton.size.width/2)
        var buttonsY = view.bounds.minY + (attackerButton.size.height/2)
        attackerButton.position = CGPointMake(buttonsX, buttonsY)
        
        buttonsX += attackerCostLabel.frame.width * 1.5
        attackerCostLabel.position = CGPointMake(buttonsX, buttonsY - attackerCostLabel.frame.height)
        
        buttonsX += defenderButton.size.width
        defenderButton.position = CGPointMake(buttonsX, buttonsY)
        
        buttonsX += defenderCostLabel.frame.width * 1.5
        defenderCostLabel.position = CGPointMake(buttonsX, buttonsY - defenderCostLabel.frame.height)
        
        buttonsX += minerButton.size.width
        minerButton.position = CGPointMake(buttonsX, buttonsY)
        
        buttonsX += minerCostLabel.frame.width * 1.5
        minerCostLabel.position = CGPointMake(buttonsX, buttonsY - minerCostLabel.frame.height)
        
        self.addChild(attackerButton)
        self.addChild(attackerCostLabel)
        
        self.addChild(defenderButton)
        self.addChild(defenderCostLabel)
        
        self.addChild(minerButton)
        self.addChild(minerCostLabel)
    }
    
    func setupPlayers(view: SKView) {
        /* Setup Players/Bases */
        // Player 1
        player1 = Player(view: view)
        player1.setPosition("left")
        p1StartingPosition = CGPointMake(player1.wall.position.x + 50, player1.wall.position.y)
        
        // Player 2
        player2 = Player(view: view)
        player2.setPosition("right")
        p2StartingPosition = CGPointMake(player2.wall.position.x - 50, player2.wall.position.y)
        
        for sprite in player1.sprites {
            self.addChild(sprite)
        }
        for sprite in player2.sprites {
            self.addChild(sprite)
        }
    }
    
    func setupNumMiners() {
        p1NumMinersLabel = SKLabelNode(text: "\(player1.goldMine.workers)")
        
        p1NumMinersLabel.fontSize = labelFontSize
        
        p1NumMinersLabel.position = CGPointMake(player1.goldMine.position.x, player1.goldMine.position.y + (player1.goldMine.size.height / 4))
        
        self.addChild(p1NumMinersLabel)
    }
    
    func incrementTimer() {
        clock.tick()
        timerLabel.text = clock.getTime()
    }
    
    func incrementGold() {
        player1.incrementGold()
        player2.incrementGold()
        
        updateGoldLabel()
    }
    
    func updateGoldLabel() {
        p1GoldLabel.text = "Gold: \(player1.gold)"
        p1GoldLabel.position = CGPointMake(viewController.skView.bounds.minX + (p2GoldLabel.frame.width / 2), viewController.skView.bounds.maxY - p1GoldLabel.frame.height)
        p2GoldLabel.text = "Gold: \(player2.gold)"
    }
    
    func updateNumMinersLabel() {
        p1NumMinersLabel.text = "\(player1.goldMine.workers)"
    }
    
    func startTimer(view: SKView) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("incrementTimer"), userInfo: nil, repeats: true)
        goldTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("incrementGold"), userInfo: nil, repeats: true)
        
        timerLabel = SKLabelNode(text: clock.getTime())
        timerLabel.fontSize = 20
        timerLabel.position = CGPointMake(view.bounds.midX, view.bounds.maxY-(timerLabel.frame.height))

        self.addChild(timerLabel)
    }
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.04, alpha: 1)
        
        clock = Clock()
        
        setupPlayers(view)
        
        /* Load everything after this point */
        createButtons(view)
        createGoldLabels(view)
        setupNumMiners()
        setUpAttackerPaths()
        
        startTimer(view)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let node = nodeAtPoint(location)
            
            if node == attackerButton {
                if (player1.attackerCost <= player1.gold) {
                    let attacker = Attacker()
                    
                    attacker.target = player2.wall
                    
                    player1.decrementGold(player1.attackerCost)
                    
                    updateGoldLabel()
                    
                    attacker.position = p1StartingPosition
                    
                    let path = SKAction.followPath(p1AttackerPath, asOffset: false, orientToPath: false, duration: 15)
                    
                    attacker.run()
                    
                    attacker.runAction(path, completion: {
                        attacker.removeActionForKey("run")
                        attacker.attack()
                    })
                    
                    self.addChild(attacker)
                }
            } else if node == minerButton {
                if (player1.minerCost <= player1.gold) {
                    let miner = Miner()
                    
                    player1.decrementGold(player1.minerCost)
                    
                    updateGoldLabel()
                    
                    miner.position = p1StartingPosition
                    
                    let path = SKAction.followPath(p1MinerPath, asOffset: false, orientToPath: false, duration: 5)
                    
                    miner.walk()
                    
                    miner.runAction(path, completion: {
                        miner.removeActionForKey("walk")
                        miner.removeFromParent()
                        self.player1.goldMine.incrementWorkers()
                        self.updateNumMinersLabel()
                    })
                    
                    self.addChild(miner)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}