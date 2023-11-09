//
//  Zukunftstag2App.swift
//  Zukunftstag2
//
//  Created by Raphael Neuenschwander on 03.02.21.
//  Copyright © 2021 Apps with love. All rights reserved.
//

import SwiftUI

@main
struct Zukunftstag2App: App {
    @State var gameStarted: Bool = false
    @State var gameOver: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if gameStarted {
                GameView(onFinish: {
                    gameStarted = false
                    gameOver = true
                })
            } else {
                if gameOver {
                    GameOverView(onEnded: {
                        gameOver = false
                    })
                } else {
                    StartView(startGame: {
                        gameStarted = true
                    })
                }
            }
        }
    }
}
