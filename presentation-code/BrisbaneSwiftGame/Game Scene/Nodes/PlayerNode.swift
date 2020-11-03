//
//  PlayerNode.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 27/10/20.
//

import Foundation
import SpriteKit

class PlayerNode : SKSpriteNode {

    func setupPhysics() {
        let body = SKPhysicsBody(circleOfRadius: 16)
        body.allowsRotation = false
        body.categoryBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.enemy
        body.collisionBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.enemy
        body.contactTestBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.enemy
        self.physicsBody = body
    }
    
    func move(in direction:Direction) {
        
        animateFor(direction: direction)
        
        switch direction {
        case let .left(moving):
            physicsBody?.velocity = .init(dx: moving ? -100 : 0, dy: 0)
            break
        case let .right(moving):
            physicsBody?.velocity = .init(dx: moving ? 100 : 0, dy: 0)
            break
        case let .up(moving):
            physicsBody?.velocity = .init(dx: 0, dy: moving ? 100 : 0)
            break
        case let .down(moving):
            physicsBody?.velocity = .init(dx: 0, dy: moving ? -100 : 0)
            break
        }
    }
    
    func attack(in direction:Direction) {
        
        attackAnimation(direction: direction)
        
        let attackNode = createAttackNode()
        
        switch direction {
        case .left:
            attackNode.position = .init(x: -16, y: 0)
            break
        case .right:
            attackNode.position = .init(x: 16, y: 0)
            break
        case .up:
            attackNode.position = .init(x: 0, y: 16)
            break
        case .down:
            attackNode.position = .init(x: 0, y: -16)
            break
        }
        
        addChild(attackNode)
        
        attackNode.run(.sequence([.wait(forDuration: 0.3),.removeFromParent()]))
    }
    
    func createAttackNode() -> SKSpriteNode {
        
        let attackNode = SKSpriteNode(color: .clear, size: .init(width: 48, height: 48))
        attackNode.name = "weapon"
        
        let body = SKPhysicsBody(rectangleOf: attackNode.size)
        body.allowsRotation = false
        body.categoryBitMask = GameScene.PhysicsCategory.weapon
        body.collisionBitMask = 0
        body.contactTestBitMask = GameScene.PhysicsCategory.weapon
        attackNode.physicsBody = body
        
        return attackNode
    }
    
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
