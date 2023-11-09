//
//  GameView.swift
//  Zukunftstag2
//
//  Created by Alain Stulz on 09.11.2023.
//  Copyright © 2023 Apps with love. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @State private var playerOffset = CGSize.zero
    @State private var dragOffset = CGSize.zero
    
    @State var monsterOffsetX: CGFloat = 0.0
    @State var monsterOffsetY: CGFloat = 200.0
    
    let screenBounds = UIScreen.main.bounds
    
    let onFinish: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("🏁 ZIEL 🏁")
                    .font(.headline)
                    .bold()
            }
            
            Text("👾")
                .font(.system(size: 64))
                .offset(x: monsterOffsetX, y: monsterOffsetY)
            
            Text("👻")
                .font(.system(size: 64))
                .offset(x: playerOffset.width + dragOffset.width,
                        y: playerOffset.height + dragOffset.height)
                .gesture(DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                        checkIsWithinBounds()
                    }
                    .onEnded({ value in
                        dragOffset = .zero
                        playerOffset.width += value.translation.width
                        playerOffset.height += value.translation.height
                        checkIsWithinBounds()
                    })
                )
        }
    }
    
    func checkIsWithinBounds() {
        let totalOffsetX = playerOffset.width + dragOffset.width
        let totalOffsetY = playerOffset.height + dragOffset.height
        
        if abs(totalOffsetX) > (screenBounds.width / 2) - 5 {
            onFinish()
        }
        
        if abs(totalOffsetY) > (screenBounds.height / 2) - 5 {
            onFinish()
        }
    }
}

#Preview {
    GameView(onFinish: { print("Finished") })
}
