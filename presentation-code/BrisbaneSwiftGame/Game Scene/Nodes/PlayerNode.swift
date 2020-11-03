//
//  PlayerNode.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 27/10/20.
//

import Foundation
import SpriteKit

class PlayerNode : SKSpriteNode {

    
}


//Texture handling
extension PlayerNode {
    
    func animateFor(direction:Direction) {
        
        self.removeAllActions()
        
        let textures = animationTexturesFor(direction: direction)
        
        if textures.count == 1 {
            self.texture = textures[0]
            return
        }
        
        print("animating")
        
        let action = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: false)
        
        self.run(.repeatForever(action))
    }
    
    func attackAnimation(direction:Direction) {
        
        self.removeAllActions()
        
        let textures = animationTexturesFor(direction: direction, attacking: true)
        
        self.run(.animate(with: textures, timePerFrame: 0.1, resize: false, restore: true))
    }
    
    func animationTexturesFor(direction:Direction,attacking:Bool = false) -> [SKTexture] {
        switch direction {
        case let .down(moving):
            return texturesFor(directionName: "down", moving: moving, attacking: attacking)
        case let .up(moving):
            return texturesFor(directionName: "up", moving: moving, attacking: attacking)
        case let .left(moving):
            return texturesFor(directionName: "left", moving: moving, attacking: attacking)
        case let .right(moving):
            return texturesFor(directionName: "right", moving: moving, attacking: attacking)
        }
    }
    
    func texturesFor(directionName:String,moving:Bool,attacking:Bool) -> [SKTexture] {
        if attacking {
            return texturesFor(name: "\(directionName)-attack", count: 3)
        }
        
        if !moving {
            return [.init(imageNamed: "player-\(directionName)-1")]
        }
        return texturesFor(name: directionName)
    }
    
    func texturesFor(name:String,count:Int = 4) -> [SKTexture] {
        
        var textures = [SKTexture]()
        
        for i in 1...count {
            textures.append(.init(imageNamed: "player-\(name)-\(i)"))
        }
        
        return textures
    }
    
}
