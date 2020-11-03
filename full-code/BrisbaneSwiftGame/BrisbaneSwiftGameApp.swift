//
//  BrisbaneSwiftGameApp.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 19/10/20.
//

import SwiftUI

@main
struct BrisbaneSwiftGameApp: App {
    
    let controller = SceneController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(controller)
        }
    }
}
