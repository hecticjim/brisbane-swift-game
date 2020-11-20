//
//  GameOverView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 3/11/20.
//

import SwiftUI

struct GameOverView: View {
    
    let tapAction : ()->()
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.6)
                .aspectRatio(1, contentMode: .fill)
            HStack {
                Spacer()
                VStack {
                    Text("Game Over")
                        .font(.adventure(size: 50))
                        .foregroundColor(.red)
                        .padding(.bottom)
                    Text("Tap to restart")
                        .font(.adventure(size: 28))
                        .foregroundColor(.white)
                        .padding(.bottom,60)
                }.onTapGesture {
                    tapAction()
                }
                Spacer()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(tapAction: {}).previewLayout(.fixed(width: 600.0, height: 375.0))
    }
}
