//
//  GameOverView.swift
//  Test2
//
//  Created by yatziri on 13/12/23.
//


import SwiftUI

/**
 * # GameOverView
 *   This view is responsible for showing the game over state of the game.
 *  Currently it only present buttons to take the player back to the main screen or restart the game.
 *
 *  You can also present score of the player, present any kind of achievements or rewards the player
 *  might have accomplished during the game session, etc...
 **/




struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack{
            VStack(alignment: .center) {
                Spacer()
                
                Button {
                    withAnimation { self.backToMainScreen() }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle()
                    .foregroundColor(Color(UIColor(red: 0.98, green: 0.38, blue: 0.61, alpha: 1)
))
                    .frame(width: 100, height: 100, alignment: .center))
                
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle()
                    .foregroundColor(Color(UIColor(red: 0.98, green: 0.38, blue: 0.61, alpha: 1)
))
                    .frame(width: 100, height: 100, alignment: .center))
                
                
                Spacer()
            }
        }
        .background(Image("BG_BL")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1170, height: 2532))
        
        
        .statusBar(hidden: true)
    }
    
    private func backToMainScreen() {
        self.currentGameState = .chooseChar
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}


//
//struct GameOverView: View {
//
//    @Binding var currentGameState: GameState
//
//    var body: some View {
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//
//            VStack(alignment: .center) {
//                Spacer()
//
//                Button {
//                    withAnimation { self.backToMainScreen() }
//                } label: {
//                    Image(systemName: "arrow.backward")
//                        .foregroundColor(.black)
//                        .font(.title)
//                }
//                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
//
//                Spacer()
//
//                Button {
//                    withAnimation { self.restartGame() }
//                } label: {
//                    Image(systemName: "arrow.clockwise")
//                        .foregroundColor(.black)
//                        .font(.title)
//                }
//                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
//
//                Spacer()
//            }
//        }
//        .statusBar(hidden: true)
//    }
//
//    private func backToMainScreen() {
//        self.currentGameState = .chooseChar
//    }
//
//    private func restartGame() {
//        self.currentGameState = .playing
//    }
//}

#Preview {
    GameOverView(currentGameState: .constant(GameState.gameOver))
}
