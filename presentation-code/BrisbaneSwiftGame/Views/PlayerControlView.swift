//
//  PlayerControlView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 20/10/20.
//

import SwiftUI

struct PlayerControlShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.66))
        path.addLine(to: CGPoint(x: rect.maxX * 0.60, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.40, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY * 0.66))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}

struct PlayerControlView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlView(controller: GameController())
    }
}
