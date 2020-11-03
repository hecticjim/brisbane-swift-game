//
//  MessageView.swift
//  BrisbaneSwiftGame
//
//  Created by James Swiney on 21/10/20.
//

import SwiftUI

struct MessageView: View {
    let message : String
    let dismissAction : ()->()
    @State var text = ""
    
    init(message:String,dismissAction:@escaping ()->()) {
        self.message = message
        self.dismissAction = dismissAction
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack(alignment: .top) {
                    VStack {
                        Text(self.message)
                            .font(.adventure(size: 30))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .modifier(TypingText(text: text,font: .adventure(size: 30)))
                            .animation(.linear(duration: 3))
                        Spacer()
                    }
                    Spacer()
                }.padding()
                .frame(height:proxy.size.height * 0.45)
                .border(Color.green, width: 5)
                .border(Color.white, width: 2)
                .background(Color.black.opacity(0.9))
            }
        }.onAppear {
            self.text = message
        }.onTapGesture {
            dismissAction()
        }
    }
}

struct TypingText : AnimatableModifier {
    
    let text : String
    var letterCount : Double
    let font : Font
    
    init(text:String,font:Font) {
        self.text = text
        letterCount = Double(text.count)
        self.font = font
    }
    
    var animatableData: Double {
        get { letterCount }
        set { letterCount = newValue }
    }
    
    func body(content: Content) -> some View {
        
        var stringVal = ""
        
        if letterCount >= 0 {
            stringVal = String(text.prefix(Int(ceil(letterCount))))
        }

        return Text(stringVal)
            .font(font)
            .foregroundColor(.white)
            .animation(nil)
    }
    
}
