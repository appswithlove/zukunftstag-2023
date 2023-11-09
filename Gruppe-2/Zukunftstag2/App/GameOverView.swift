//
//  GameOverView.swift
//  Zukunftstag2
//
//  Created by Alain Stulz on 09.11.2023.
//  Copyright © 2023 Apps with love. All rights reserved.
//

import SwiftUI

struct GameOverView: View {
    let onEnded: () -> Void
    
    var body: some View {
        Text("Game Over!")
            .font(.title)
        
        ExitButton()
            .zIndex(1)
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
    func ExitButton() -> some View {
        GameButton(action: onEnded) {
            Text("To Start")
        }
    }

}

#Preview {
    GameOverView(onEnded: {})
}
