//
//  EmojyGameViewModel.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 30.04.24.
//

import Foundation

class EmojyGameViewModel: ObservableObject {
    static var emojis = ["🐨" , "🦁", "🙊", "🦋", "🇬🇪", "🐯", "🪀", "🍎", "🥬", "🖥️", "📸", "👀", "👩🏻‍🦳", "🙈"]
    typealias MemoryGameTypealias = MemoryGame<String>
    @Published private var model: MemoryGameTypealias 
    
    var cards: [MemoryGameTypealias.Card] {
        model.cards
    }
    
    func chooseCard(card: MemoryGameTypealias.Card) {
        model.chooseCard(card: card)
    }
    
    static func cardFactory(index: Int) -> String {
       guard index <= emojis.count else { return "NO"}
        return emojis[index]
    }
    
    init() {
        self.model = MemoryGameTypealias(
            numberOfPairsOfCard: 5,
            cardFactory: EmojyGameViewModel.cardFactory)
    }
}
