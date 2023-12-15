//
//  PauseView.swift
//  Test2
//
//  Created by Claudia De Luca on 15/12/23.
//

import SwiftUI

struct PauseView: View {
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        VStack{
            Text("Pause")
                .font(.custom("Atlantis Headline",
                              size: 40, relativeTo: .headline))
                .foregroundStyle(Color.white)
            Button(action: {
                currentGameState = .pause
            }, label: {
                Image("pauseButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            })
        }.background(Image("BG_BL")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1170, height: 2532))
    }
}

#Preview {
    PauseView(currentGameState: .constant(.pause))
}
