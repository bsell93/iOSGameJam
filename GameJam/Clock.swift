//
//  Clock.swift
//  GameJam
//
//  Created by Bryant_Sell on 11/22/14.
//  Copyright (c) 2014 bsell. All rights reserved.
//

import Foundation

class Clock: NSObject {
    
    var minute: Int = 0
    var second: Int = 0
    
    func tick() {
        if (second == 59) {
            minute += 1
            second = 0
        } else {
            second += 1
        }
    }
    
    func getTime() -> String {
        return String(format: "%02d:%02d", minute,second)
    }
}