//
//  GameController.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 19/10/20.
//

import Foundation
import SpriteKit
import GameKit
import Combine

class SceneController : ObservableObject {
    
    let gameController = GameController()
    
    @Published var gameScene : GameScene
    @Published var message : String?
    @Published var isPaused = false
    @Published var score = 0
    @Published var gameOver = false
    
    var eventSubscriptions = Set<AnyCancellable>()
    
    init() {
        gameScene = (GKScene(fileNamed: "GameScene")!.rootNode as! GameScene)
        gameScene.handleEvents(controller:gameController)
        handleEvents()
    }
    
    func handleEvents() {
        gameController.$isPaused.assign(to: \.isPaused, on: self).store(in: &eventSubscriptions)
        gameController.$message.assign(to: \.message, on: self).store(in: &eventSubscriptions)
        gameController.$score.assign(to: \.score, on: self).store(in: &eventSubscriptions)
        gameController.$dead.assign(to: \.gameOver, on: self).store(in: &eventSubscriptions)
    }
    
    func dismissMessage() {
        self.gameController.message = nil
        self.gameController.isPaused = false
    }
    
    func restartGame() {
        gameController.reset()
        gameScene = (GKScene(fileNamed: "GameScene")!.rootNode as! GameScene)
        gameScene.handleEvents(controller:gameController)
    }
}
