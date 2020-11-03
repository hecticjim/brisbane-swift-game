//
//  EnemyNode.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 2/11/20.
//

import UIKit
import SpriteKit

class EnemyNode: SKSpriteNode {

    func setup() {
        setupPhysics()
        startAnimation()
    }
    
    func setupPhysics() {
        let body = SKPhysicsBody(circleOfRadius: 16)
        body.allowsRotation = false
        body.categoryBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.weapon
        body.collisionBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.enemy
        body.contactTestBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.weapon
        self.physicsBody = body
    }
    
    func startAnimation() {
        run(.repeatForever(.animate(with: [.init(imageNamed: "blob-1"),.init(imageNamed: "blob-2")], timePerFrame: 0.2)))
    }
    
}
