//
//  ContentView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 19/10/20.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @EnvironmentObject var controller : SceneController
    
    var body: some View {
        ZStack {
            SpriteView(scene: controller.gameScene).edgesIgnoringSafeArea(.all)
            GameInterfaceView().zIndex(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SceneController())
            .previewLayout(.fixed(width: 600.0, height: 375.0))
    }
}
