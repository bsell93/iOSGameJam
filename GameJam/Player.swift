//
//  Player.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation


class Player: NSObject {
    
    var gold: Int = 10
    var units: Int = 0
    var ability: String!
    
    var castle: Castle!
    var wall: Wall!
    
    override init () {
        ability = "None"
        
        castle = Castle()
        wall = Wall()
    }
    
    func incrementGold() {
        gold += 10
    }
}