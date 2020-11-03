//
//  GameController.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 20/10/20.
//

import Foundation
import Combine

class GameController {
    
    @Published var direction = Direction.right(false)
    @Published var isPaused = false
    @Published var message : String?
    @Published var attack = false
    @Published var score = 0
    @Published var dead = false
    
    func reset() {
        direction = Direction.right(false)
        isPaused = false
        message = nil
        attack = false
        score = 0
        dead = false
    }
}
