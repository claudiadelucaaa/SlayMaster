//
//  GameDurationView.swift
//  Test2
//
//  Created by yatziri on 12/12/23.
//

import SwiftUI

/**
 * # GameDurationView
 * Custom UI to present how many seconds have passed since the beginning of the gameplay session.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameDurationView: View {
    @Binding var lives: Int
    
    var body: some View {
            HStack {
                ForEach(0..<lives, id: \.self) { index in
                    Image("Laca")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50)
                }
                
                Spacer()
                Text("\(lives)")
                    .font(.custom("Atlantis Headline", size: 20, relativeTo: .headline))
                    .foregroundColor(.white)
                    .padding()
            }.frame(width: 230, height: 30)
                .padding(24)
                .foregroundColor(.black)
                .background(Color(UIColor(red: 0.98, green: 0.38, blue: 0.61, alpha: 1)))
                .cornerRadius(10)
            
        }
    }

#Preview {
    GameDurationView(lives: .constant(3))
        .previewLayout(.fixed(width: 300, height: 100))
}
