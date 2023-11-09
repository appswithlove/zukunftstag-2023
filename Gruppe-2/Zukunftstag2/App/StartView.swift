//
//  StartView.swift
//  Zukunftstag2
//
//  Created by Alain Stulz on 09.11.2023.
//  Copyright © 2023 Apps with love. All rights reserved.
//

import SwiftUI

struct StartView: View {
    let startGame: () -> Void
    
    @State var buttonOffsetX: CGFloat = 0.0
    @State var buttonOffsetY: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 80) {
            Text("Mini Game")
                .font(.title)
            
            PlayButton()
                .zIndex(2)
            
            ExitButton()
                .zIndex(1)
        }
    }
    
    @ViewBuilder
    func GameButton<Label: View>(action: @escaping () -> Void, label: () -> Label) -> some View {
        Button(role: nil, action: action, label: {
            label()
                .font(.largeTitle)
                .foregroundColor(.white)
        })
        .padding(.vertical, 10)
        .padding(.horizontal, 25)
        .background(content: {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.black)
        })
    }
    
    @ViewBuilder
    func PlayButton() -> some View {
        GameButton(action: {
            moveButtonToRandomPosition()
        }, label: {
            Text("Play")
        })
        .animation(.easeInOut, value: buttonOffsetX)
        .animation(.easeInOut, value: buttonOffsetY)
        .offset(x: buttonOffsetX, y: buttonOffsetY)
    }
    
    @ViewBuilder
    func ExitButton() -> some View {
        GameButton(action: startGame) {
            Text("Exit")
        }
    }
    
    func moveButtonToRandomPosition() {
        buttonOffsetX = CGFloat.random(in: -100...100)
        buttonOffsetY = CGFloat.random(in: -300...300)
    }
}

#Preview {
    StartView(startGame: {
        print("Start Game")
    })
}
