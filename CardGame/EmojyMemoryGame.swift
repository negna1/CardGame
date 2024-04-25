//
//  EmojyMemoryGame.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 28.03.24.
//

import Foundation

class EmojyMemoryGame: ObservableObject {
    static let emojyArrays = ["🥹","☎️","💸","💌", "🥺", "🤯" ,"😶‍🌫️", "😈" ,"🫶"]
    typealias MemorizeGameModel = MemorizeGame<String>
    init() {
        model = MemorizeGameModel(with: numberOfPairs,
                                  cardContentFactory: {
            EmojyMemoryGame.emojyArrays.indices.contains($0) ? EmojyMemoryGame.emojyArrays[$0] : "😑"
        })
    }
    private (set) var numberOfPairs: Int = 4 {
        didSet {
            model = MemorizeGameModel(with: numberOfPairs,
                                      cardContentFactory: {
                EmojyMemoryGame.emojyArrays.indices.contains($0) ? EmojyMemoryGame.emojyArrays[$0] : "😑"
            })
        }
    }
    @Published private var model: MemorizeGameModel
    
    func changeNumberOfPairs(_ offset: Int) {
        numberOfPairs += offset
    }
    
    func isDisabled(type: EmojiAddType) -> Bool {
        switch type {
        case .add:
            numberOfPairs >= EmojyMemoryGame.emojyArrays.count
        case .remove:
            EmojyMemoryGame.emojyArrays.count <= 0
        }
    }
    
    func shuffle() {
        model.shuffleCards()
    }
    
    var cards: [MemorizeGameModel.Card] {
        model.cards
    }
    
    func chooseCard(_ card: MemorizeGameModel.Card) {
        model.chooseCard(card)
    }
}
