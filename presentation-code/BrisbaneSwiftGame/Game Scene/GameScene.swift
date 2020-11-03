//
//  GameScene.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 19/10/20.
//

import SpriteKit
import Combine

class GameScene: SKScene {
    
    struct PhysicsCategory {
        static let player : UInt32 = 0b1 << 0
        static let weapon : UInt32 = 0b1 << 1
        static let enemy : UInt32 = 0b1 << 2
        static let weaponNoCollision : UInt32 = 0b1 << 2
    }

}


//Physics collision handling
extension GameScene : SKPhysicsContactDelegate {
    
    func setupSignPhysics() {
        guard let sign = childNode(withName: "sign") as? SKSpriteNode else { return }
        let body = SKPhysicsBody(circleOfRadius: sign.size.width / 2)
        body.isDynamic = false
        body.contactTestBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.weapon
        body.collisionBitMask = GameScene.PhysicsCategory.player
        body.categoryBitMask = GameScene.PhysicsCategory.player | GameScene.PhysicsCategory.weapon
        body.allowsRotation = false
        sign.physicsBody = body
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        handleSign(contact: contact)
        handleAttackOnEnemy(contact: contact)
        handleAttackOnPlayer(contact: contact)
    }
    
    func handleSign(contact:SKPhysicsContact) {
        guard checkContactNodesContain(names: ["player","sign"], contact: contact) else {
            return
        }

    }
    
    func handleAttackOnEnemy(contact:SKPhysicsContact) {
        guard let enemy = findNodeInContact(with: "enemy", contact: contact), checkContactNodesContain(names: ["weapon","enemy"], contact: contact) else { return }
        
    }
    
    func handleAttackOnPlayer(contact:SKPhysicsContact) {
        guard checkContactNodesContain(names: ["player","enemy"], contact: contact) else {
            return
        }

    }
}
