//
//  PlayerControlView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 20/10/20.
//

import SwiftUI

struct PlayerControlView: View {
    
    let controller : GameController
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                DPad { (event) in
                    controller.direction = event
                }
                Spacer()
                ControlButton { (pressed) in
                    controller.attack = pressed
                }
            }
        }
    }
}

struct ControlButton: View {
    
    var actionHandler : (Bool)->()
    @State var pressed = false
    
    var drag : some Gesture {
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in
                if pressed {
                    return
                }
                pressed = true
                actionHandler(true)
            }
            .onEnded { _ in
                pressed = false
                actionHandler(false)
            }
        return dragGesture
    }
    
    var body: some View {
        Circle().fill().foregroundColor(Color(UIColor.white.withAlphaComponent(pressed ? 1 : 0.5))).frame(width: 50, height: 50).gesture(drag)
    }
    
}

struct DPad : View {
    
    let eventHandler : (Direction)->()
    
    var body: some View {
        ZStack {
            HStack {
                PlayerControlButton(rotation: 270) { (pressed) in
                    eventHandler(.left(pressed))
                }
                Spacer().frame(width:30)
                PlayerControlButton(rotation: 90) { (pressed) in
                    eventHandler(.right(pressed))
                }
            }
            VStack {
                PlayerControlButton(rotation: 0) { (pressed) in
                    eventHandler(.up(pressed))
                }
                Spacer().frame(height:30)
                PlayerControlButton(rotation: 180) { (pressed) in
                    eventHandler(.down(pressed))
                }
            }
        }
    }
    
}

struct PlayerControlButton : View {
    
    let rotation : Double
    let actionHandler : (Bool)->()
    @State var pressed = false
    
    var drag : some Gesture {
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in
                if pressed {
                    return
                }
                pressed = true
                actionHandler(true)
            }
            .onEnded { _ in
                pressed = false
                actionHandler(false)
            }
        return dragGesture
    }
    
    var body : some View {
        PlayerControlShape()
            .fill()
            .foregroundColor(.white)
            .frame(width:50, height: 50)
            .cornerRadius(10)
            .rotationEffect(.degrees(rotation), anchor: .center)
            .opacity(pressed ? 1 : 0.5)
            .shadow(radius: pressed ? 0 : 10)
            .gesture(drag)
    }
}

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
        PlayerControlView(controller: GameController()).previewLayout(.fixed(width: 600.0, height: 375.0))
    }
}
