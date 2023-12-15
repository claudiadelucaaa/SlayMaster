//
//  GameScoreView.swift
//  Test2
//
//  Created by yatziri on 12/12/23.
//
import SwiftUI

struct GameScoreView: View {
    @Binding var score: Int
    
    var body: some View {
        
        HStack {
            Image(systemName: "target")
                .font(.headline)
            Spacer()
            Text("\(score)")
                .font(.headline)
        }
        .frame(minWidth: 100)
        .padding(24)
        .foregroundColor(.black)
        .background(Color(UIColor(red: 0.98, green: 0.38, blue: 0.61, alpha: 0.5)
))

        .cornerRadius(10)
    }
}

#Preview {
    GameScoreView(score: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}
