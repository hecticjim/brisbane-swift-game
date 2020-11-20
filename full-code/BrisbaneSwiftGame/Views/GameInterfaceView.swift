//
//  GameInterfaceView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 21/10/20.
//

import SwiftUI

struct GameInterfaceView: View {
    
    @EnvironmentObject var controller : SceneController
    
    var body: some View {
        ZStack {
            if !controller.isPaused && !controller.gameOver {
                PlayerControlView(controller: controller.gameController).zIndex(1)
            }
            
            if controller.message != nil {
                MessageView(message: controller.message!, dismissAction: {
                    controller.dismissMessage()
                })
                    .edgesIgnoringSafeArea(.bottom)
                    .transition(.move(edge: .bottom))
                    .animation(.default)
            }
            
            ScoreView(score: controller.score)
            
            if controller.gameOver {
                GameOverView {
                    controller.restartGame()
                }.edgesIgnoringSafeArea(.all)
                .transition(.opacity)
                .animation(.default)
            }
        }
    }
}

struct GameInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        GameInterfaceView().previewLayout(.fixed(width: 600.0, height: 375.0)).environmentObject(SceneController())
    }
}
