//
//  ScoreView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 2/11/20.
//

import SwiftUI

struct ScoreView: View {
    
    let score : Int
    
    var body: some View {
        HStack {
            VStack {
                Text("Score : \(score)")
                    .font(.adventure(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(8)
                    .padding(.top)
                Spacer()
            }
            Spacer()
        }
    }
}


struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score:1000).previewLayout(.fixed(width: 600.0, height: 375.0))
    }
}
