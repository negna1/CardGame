//
//  ContentView.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 26.03.24.
//

import SwiftUI

struct ContentView: View {
    @State var emojisCount = 4
    var emojis = ["🥹","🙂","😍","😙", "🥺", "🤯" ,"😶‍🌫️" , "🥹","🙂","😍","😙", "🥺", "🤯" ,"😶‍🌫️"]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
            ForEach(0..<emojisCount, id: \.self){i in
                CardView(emojy: emojis[i])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        })
        .foregroundColor(.orange)
        .padding()
        Spacer()
        cardAdjusters
    }
    
    var cardAdjusters: some View {
        HStack {
            buttonView(type: .add)
            Spacer()
            buttonView(type: .remove)
        }
        .imageScale(.large)
        .foregroundColor(.yellow)
        .padding()
    }
    
    func buttonView(type: EmojiAddType) -> some View {
        Button(action: {
            type.adjustNumbers(&emojisCount)
        }, label: {
            Image(systemName: type.iconName)
        }).disabled(type.isDisabled(currentEmojisCount: emojisCount, emojisCount: emojis.count))
    }
}

struct CardView: View {
    @State var isFaceUp: Bool
    private let emojy: String
    init(isFaceUp: Bool = true, emojy: String) {
        self.isFaceUp = isFaceUp
        self.emojy = emojy
    }
    var body: some View {
        ZStack{
            let rectangle =  RoundedRectangle(cornerRadius: 10)
                rectangle.stroke(lineWidth: 3)
                Text(emojy)
            rectangle.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        
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
    
    func adjustNumbers(_ count: inout Int) {
        switch self {
        case .add:
            count += 1
        case .remove:
            count -= 1
        }
    }
    
    func isDisabled(currentEmojisCount: Int, emojisCount: Int) -> Bool {
        switch self {
        case .add:
            currentEmojisCount >= emojisCount
        case .remove:
            emojisCount <= 0
        }
    }
}
