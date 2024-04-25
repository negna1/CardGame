//
//  ContentView.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 26.03.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojyMemoryGame = .init()
    
    private func needToWhitePlace(_ card: MemorizeGame<String>.Card) -> Bool {
        (card.isMatched && !card.isFaceUp)
    }
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
            ForEach(viewModel.cards) {card in
                CardView(isFaceUp: card.isFaceUp, emojy: card.content)
                    .onTapGesture {
                        viewModel.chooseCard(card)
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(needToWhitePlace(card) ? .white : .orange)
                    .animation(.easeInOut, value: card)
                    .animation(.easeInOut, value: viewModel.cards)
                    .opacity(needToWhitePlace(card) ? 0 : 1)
            }
        })
        
        .padding() 
        Spacer()
        cardAdjusters
    }
    
    var cardAdjusters: some View {
        HStack {
            buttonView(type: .add)
            Button {
                viewModel.shuffle()
            } label: {
                Text("shuffle")
            }

            buttonView(type: .remove)
        }
        .imageScale(.large)
        .foregroundColor(.yellow)
        .padding()
    }
    
    func buttonView(type: EmojiAddType) -> some View {
        Button(action: {
            viewModel.changeNumberOfPairs(type.offset)
        }, label: {
            Image(systemName: type.iconName)
        }).disabled(viewModel.isDisabled(type: type))
    }
}

struct CardView: View {
    private var isFaceUp: Bool
    private let emojy: String
    init(isFaceUp: Bool, emojy: String) {
        self.isFaceUp = isFaceUp
        self.emojy = emojy
    }
    
    var body: some View {
        ZStack{
            let rectangle =  RoundedRectangle(cornerRadius: 10)
            Group {
                rectangle.fill(.white)
                rectangle.stroke(lineWidth: 3)
                Text(emojy)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(isFaceUp ? 1 : 0)
            rectangle.fill().opacity(isFaceUp ? 0 : 1)
        }.font(.title)
        
    }
}

#Preview {
    ContentView()
}

enum EmojiAddType {
    case add
    case remove
}

extension EmojiAddType {
    var iconName: String {
        switch self {
        case .add:
            "plus.circle.fill"
        case .remove:
            "minus.circle.fill"
        }
    }
    
    var offset: Int {
        switch self {
        case .add:
             1
        case .remove:
            -1
        }
    }
}
