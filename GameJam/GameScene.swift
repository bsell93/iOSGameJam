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
    
    var gameOver: Bool = false
    
    var timer: NSTimer!
    var goldTimer: NSTimer!
    
    var clock: Clock!
    var timerLabel: SKLabelNode!
    
    var player1: Player!
    var computer: Computer!
    
    var p1Ability: Ability!
    
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
    
    func setUpMinerPaths() {
        /* Miner Path */
        p1MinerPath = CGPathCreateMutable()
        p2MinerPath = CGPathCreateMutable()
        
        CGPathMoveToPoint(p1MinerPath, nil, p1StartingPosition.x, p1StartingPosition.y)
        CGPathMoveToPoint(p2MinerPath, nil, p2StartingPosition.x, p2StartingPosition.y)
        
        CGPathAddLineToPoint(p1MinerPath, nil, player1.goldMine.position.x, player1.goldMine.position.y - player1.goldMine.size.height)
        CGPathAddLineToPoint(p2MinerPath, nil, computer.goldMine.position.x, computer.goldMine.position.y + computer.goldMine.size.height)
    }
    
    func createGoldLabels(view: SKView) {
        p1GoldLabel = SKLabelNode(text: "Gold: \(player1.gold)")
        p2GoldLabel = SKLabelNode(text: "Gold: \(computer.gold)")
        
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
        player1.ability = p1Ability
        player1.setPosition("left")
        p1StartingPosition = CGPointMake(player1.wall.position.x + (Attacker(playerNumber: 1).frame.width * 1.5), player1.wall.position.y)
        
        // Player 2
        computer = Computer(view: view)
        computer.setPosition("right")
        p2StartingPosition = CGPointMake(computer.wall.position.x - (Attacker(playerNumber: 2).frame.width * 1.5), computer.wall.position.y)
        
        for sprite in player1.sprites {
            self.addChild(sprite)
        }
        for sprite in computer.sprites {
            self.addChild(sprite)
        }
    }
    
    func setupNumMiners() {
        p1NumMinersLabel = SKLabelNode(text: "\(player1.goldMine.workers)")
        
        p1NumMinersLabel.fontSize = labelFontSize
        
        p1NumMinersLabel.position = CGPointMake(player1.goldMine.position.x, player1.goldMine.position.y + (player1.goldMine.size.height / 4))
        
        self.addChild(p1NumMinersLabel)
    }
    
    func incrementTimer(timer: NSTimer) {
        clock.tick()
        timerLabel.text = clock.getTime()
        
        let view = timer.userInfo as SKView
        computer.decide(view, enemy: player1, scene: self)
    }
    
    func incrementGold() {
        player1.incrementGold()
        computer.incrementGold()
        
        updateGoldLabel()
    }
    
    func updateGoldLabel() {
        p1GoldLabel.text = "Gold: \(player1.gold)"
        p1GoldLabel.position = CGPointMake(viewController.skView.bounds.minX + (p2GoldLabel.frame.width / 2), viewController.skView.bounds.maxY - p1GoldLabel.frame.height)
        p2GoldLabel.text = "Gold: \(computer.gold)"
    }
    
    func updateNumMinersLabel() {
        p1NumMinersLabel.text = "\(player1.goldMine.workers)"
    }
    
    func startTimer(view: SKView) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("incrementTimer:"), userInfo: view, repeats: true)
        goldTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("incrementGold"), userInfo: nil, repeats: true)
        
        timerLabel = SKLabelNode(text: clock.getTime())
        timerLabel.fontSize = 20
        timerLabel.position = CGPointMake(view.bounds.midX, view.bounds.maxY-(timerLabel.frame.height))

        self.addChild(timerLabel)
    }
    
    func attack(timer: NSTimer) {
        if !gameOver {
            var attacker = timer.userInfo as Attacker
            if !attacker.target.destroyed {
                attacker.target.decrementHealth(attacker.attackPower)
                if (attacker.target.hitPoints <= 0) {
                    if let index = find(computer.attackableSprites, attacker.target) {
                        computer.attackableSprites.removeAtIndex(index)
                    }
                    attacker.removeActionForKey("attack")
                    attacker.idle()
                }
            } else if !computer.attackableSprites.isEmpty {
                player1.findTarget(attacker, enemySprites: computer.attackableSprites)
            } else {
                attacker.removeActionForKey("attack")
                attacker.idle()
            }
        }
    }
    
    func attackPlayer(timer: NSTimer) {
        if !gameOver {
            var attacker = timer.userInfo as Attacker
            if !attacker.target.destroyed {
                attacker.target.decrementHealth(attacker.attackPower)
                if (attacker.target.hitPoints <= 0) {
                    if let index = find(player1.attackableSprites, attacker.target) {
                        player1.attackableSprites.removeAtIndex(index)
                    }
                    attacker.removeActionForKey("attack")
                    attacker.idle()
                }
            } else if !player1.attackableSprites.isEmpty {
                computer.findTarget(attacker, enemySprites: player1.attackableSprites)
            } else {
                attacker.removeActionForKey("attack")
                attacker.idle()
            }
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.04, alpha: 1)
        
        clock = Clock()
        
        setupPlayers(view)
        
        /* Load everything after this point */
        createButtons(view)
        createGoldLabels(view)
        setupNumMiners()
        setUpMinerPaths()
        
        startTimer(view)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let node = nodeAtPoint(location)
            
            if node == attackerButton {
                if (player1.attackerCost <= player1.gold) {
                    let attacker = Attacker(playerNumber: 1)
                    
                    player1.attackers.append(attacker)
                    player1.attackableSprites.append(attacker)
                    
                    player1.decrementGold(player1.attackerCost)
                    
                    updateGoldLabel()
                    
                    attacker.position = player1.startingPoint
                    
                    if (player1.ability == Ability.Attacker) {
                        attacker.attackPower *= 2
                    }
                    
                    player1.findTarget(attacker, enemySprites: computer.attackableSprites)
                    
                    self.addChild(attacker)
                }
            } else if node == minerButton {
                if (player1.minerCost <= player1.gold) {
                    let miner = Miner()
                    
                    player1.decrementGold(player1.minerCost)
                    
                    updateGoldLabel()
                    
                    miner.position = player1.startingPoint
                    
                    if (player1.ability == Ability.Miner) {
                        player1.minerMultiplier = 2
                    }
                    
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
        if player1.castle.hitPoints <= 0 || computer.castle.hitPoints <= 0 {
            gameOver = true
            var menu = MenuScene(size: viewController.view.bounds.size)
            menu.viewController = viewController
            viewController.skView.presentScene(menu)
        }
        for attacker in player1.attackers {
            if attacker.nearTarget() {
                if attacker.attackTimer == nil {
                    attacker.attackTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("attack:"), userInfo: attacker, repeats: true)
                }
            }
            if computer.attackableSprites.isEmpty {
                attacker.removeAllActions()
                attacker.idle()
            }
        }
        for attacker in computer.attackers {
            if attacker.nearTarget() {
                if attacker.attackTimer == nil {
                    attacker.attackTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("attackPlayer:"), userInfo: attacker, repeats: true)
                }
            }
            if player1.attackableSprites.isEmpty {
                attacker.removeAllActions()
                attacker.idle()
            }
        }
    }
}