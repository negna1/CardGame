//
//  ContentView.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 26.03.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = EmojyGameViewModel()
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))],spacing: 0, content: {
            
            ForEach(viewModel.cards) { card in
                CardView(isFaceUp: card.isFaceUp, emojy: card.content)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(3)
                    .opacity((card.isMatched && !card.isFaceUp) ? 0 : 1)
                    .onTapGesture {
                        viewModel.chooseCard(card: card)
                    }
            }
        })
        .foregroundColor(.orange)
        .padding(3)
        Spacer()
    }
}

struct CardView: View {
    var isFaceUp: Bool
    private let emojy: String
    init(isFaceUp: Bool, emojy: String) {
        self.isFaceUp = isFaceUp
        self.emojy = emojy
    }
    var body: some View {
        ZStack{
            let rectangle =  RoundedRectangle(cornerRadius: 10)
                rectangle.stroke(lineWidth: 3)
                Text(emojy)
                .font(.system(size: 120))
                .minimumScaleFactor(0.1)
                .scaledToFit()
            rectangle.fill().opacity(isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    ContentView()
}
