//
//  Helpers.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 21/10/20.
//

import Foundation
import SwiftUI
import SpriteKit

extension Font {
    
    static func adventure(size:CGFloat) -> Font {
        return .custom("Adventure-Pixels", size: size)
    }
}

extension SKScene {
    
    func randomPositionOutsideOfScene() -> CGPoint {
        
        let horizontal = Int.random(in: 1...10) > 5
        let negative = Int.random(in: 1...10) > 5
        
        let x : CGFloat = horizontal ? size.width * 0.6 : 0
        let y : CGFloat = horizontal ? 0 : size.height * 0.6
        
        return CGPoint(x: negative ? -x : x, y: negative ? -y : y)
    }
    
    func checkContactNodesContain(names:[String], contact: SKPhysicsContact) -> Bool {
        
        let contactNodeNames = [contact.bodyA,contact.bodyB].compactMap({ $0.node?.name })
        let matching = names.filter({ contactNodeNames.contains($0) })
        
        return matching == names
    }
    
    func findNodeInContact(with name:String, contact: SKPhysicsContact) -> SKNode? {
        
        let contactNodes = [contact.bodyA,contact.bodyB].compactMap({ $0.node })
        let matching = contactNodes.filter({ $0.name == name }).first

        return matching
    }
    
}
