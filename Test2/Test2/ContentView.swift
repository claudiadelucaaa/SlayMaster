//
//  ContentView.swift
//  Test2
//
//  Created by yatziri on 13/12/23.
//

import SwiftUI


struct ContentView: View {
    @State var currentGameState: GameState = .firstTime
    @State var currentDragSelected: DragChoice = .bianca
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    var body: some View {
        switch currentGameState {
        case .firstTime: StartView(currentGameState: $currentGameState)
            
        case .chooseChar:
            ChooseChar(currentGameState: $currentGameState, currentDragSelected: $currentDragSelected)
            
        case .playing:
            GameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .pause:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .gameOver:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

#Preview {
    ContentView()
}
