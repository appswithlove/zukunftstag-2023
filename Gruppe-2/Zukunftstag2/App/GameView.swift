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
    
    @State var monsterOffsetX0: CGFloat = 000.0
    @State var monsterOffsetY0: CGFloat = 200.0
    
    @State var monsterOffsetX1: CGFloat = 100.0
    @State var monsterOffsetY1: CGFloat = 200.0
    
    @State var monsterOffsetX2: CGFloat = -100.0
    @State var monsterOffsetY2: CGFloat = 200.0
    
    let screenBounds = UIScreen.main.bounds
    
    @State var is0MovingRight = true
    @State var is1MovingRight = true
    @State var is2MovingRight = false
    
    @State var playerCharacter = "👻"
    @State var playerCharacterScale: CGFloat = 1.0
    
    let onFinish: () -> Void
    
    let timer = Timer.publish(every: 0.005, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("🏁 ZIEL 🏁")
                    .font(.title)
                    .bold()
            }
            
            VStack(spacing: 0) {
                Text("👾")
                    .font(.system(size: 64))
                    .offset(x: monsterOffsetX0, y: monsterOffsetY0)
                Text("👾")
                    .font(.system(size: 64))
                    .offset(x: monsterOffsetX1, y: monsterOffsetY1)
                Text("👾")
                    .font(.system(size: 64))
                    .offset(x: monsterOffsetX2, y: monsterOffsetY2)
            }
            
            Text(playerCharacter)
                .font(.system(size: 64))
                .scaleEffect(playerCharacterScale)
                .offset(x: playerOffset.width + dragOffset.width,
                        y: playerOffset.height + dragOffset.height)
                .gesture(DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                        checkIsWithinBounds()
                        checkIsOnGoal()
                    }
                    .onEnded({ value in
                        dragOffset = .zero
                        playerOffset.width += value.translation.width
                        playerOffset.height += value.translation.height
                        checkIsWithinBounds()
                        checkIsOnGoal()
                    })
                )
        }.onReceive(timer, perform: { _ in
            if abs(monsterOffsetX0) > (screenBounds.width / 2) - 50 {
                is0MovingRight.toggle()
            }
            
            if abs(monsterOffsetX1) > (screenBounds.width / 2) - 50 {
                is1MovingRight.toggle()
            }
            
            if abs(monsterOffsetX2) > (screenBounds.width / 2) - 50 {
                is2MovingRight.toggle()
            }
            
            let speed = 1.0
            
            if is0MovingRight {
                monsterOffsetX0 += speed
            } else {
                monsterOffsetX0 -= speed
            }
            
            if is1MovingRight {
                monsterOffsetX1 += speed
            } else {
                monsterOffsetX1 -= speed
            }
            
            if is2MovingRight {
                monsterOffsetX2 += speed
            } else {
                monsterOffsetX2 -= speed
            }
        })
    }
    
    func checkIsWithinBounds() {
        let totalOffsetX = playerOffset.width + dragOffset.width
        let totalOffsetY = playerOffset.height + dragOffset.height
        
        if abs(totalOffsetX) > (screenBounds.width / 2) - 5 {
            finishGame()
        }
        
        if abs(totalOffsetY) > (screenBounds.height / 2) - 5 {
            finishGame()
        }
    }
    
    func checkIsOnGoal() {
        let totalOffsetY = playerOffset.height + dragOffset.height

        if totalOffsetY > (screenBounds.height / 2 - 70) {
            finishGame()
        }
    }
    
    func finishGame() {
        playerCharacter = "💥"
        playerCharacterScale = 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            onFinish()
        }
    }
}

#Preview {
    GameView(onFinish: { print("Finished") })
}
