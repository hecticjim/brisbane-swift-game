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

    var controller : GameController?
    var eventSubscriptions = Set<AnyCancellable>()
    var playerNode : PlayerNode?
    var enemies = [EnemyNode]()
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsWorld.contactDelegate = self
        playerNode = childNode(withName: "player") as? PlayerNode
        playerNode?.setupPhysics()
        setupSignPhysics()
        
        view.showsPhysics = true
        startSpawning()
    }
    
    func startSpawning() {
        run(.repeatForever(.sequence([.wait(forDuration: 3),.run({ self.spawnEnemy() })])))
    }
    
    func spawnEnemy() {
        let enemy = EnemyNode(imageNamed: "blob-1")
        enemy.name = "enemy"
        enemy.position = randomPositionOutsideOfScene()
        addChild(enemy)
        enemy.setup()
        enemies.append(enemy)
    }

    func handleEvents(controller:GameController) {
        
        eventSubscriptions.forEach({ $0.cancel() })
        
        self.controller = controller
        
        controller.$isPaused.assign(to: \.isPaused, on: self).store(in: &eventSubscriptions)
        
        controller.$direction.sink { (direction) in
            self.playerNode?.move(in: direction)
        }.store(in: &eventSubscriptions)
        
        controller.$attack.sink { (attack) in
            if !attack {
                return
            }
            self.playerNode?.attack(in: controller.direction)
        }.store(in: &eventSubscriptions)
    }

    override func update(_ currentTime: TimeInterval) {
        enemies.forEach({ $0.moveTowards(playerPosition: playerNode?.position ?? .zero) })
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
        
        controller?.message = "Hello you just touched a sign that will show you some important information"
        controller?.isPaused = true
    }
    
    func handleAttackOnEnemy(contact:SKPhysicsContact) {
        guard let enemy = findNodeInContact(with: "enemy", contact: contact), checkContactNodesContain(names: ["weapon","enemy"], contact: contact) else { return }
        
        enemy.removeFromParent()
        enemies.removeAll(where: { $0 == enemy })
        let current = controller?.score ?? 0
        controller?.score = current + 1
    }
    
    func handleAttackOnPlayer(contact:SKPhysicsContact) {
        guard checkContactNodesContain(names: ["player","enemy"], contact: contact) else {
            return
        }
        playerNode?.removeFromParent()
        controller?.dead = true
    }
}
