//
//  MemorizeGame.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 28.03.24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private (set) var cards: Array<Card>
    
    init(with numberOfPairs: Int, cardContentFactory: ((Int) -> CardContent)) {
        cards = []
        for i in 0..<numberOfPairs {
            let content = cardContentFactory(i)
            cards.append(Card(id: "a\(i)", content: content))
            cards.append(Card(id: "b\(i)", content: content))
        }
    }
    
    var oldChoosenCardIndex: Int?
        mutating func chooseCard(_ card: Card) {
            if oldChoosenCardIndex == nil {
                cards.indices.forEach({cards[$0].isFaceUp = false})
            }
            guard let (offset, _) = cards.enumerated().first(where: {$0.element == card}) else { return }
            if oldChoosenCardIndex == offset {
                cards[offset].isFaceUp.toggle()
                oldChoosenCardIndex = nil
            } else if let index = oldChoosenCardIndex {
                oldChoosenCardIndex = nil
                if cards[index].content == card.content {
                    cards[index].isMatched = true
                    cards[offset].isMatched = true
                    cards[offset].isFaceUp.toggle()
                    oldChoosenCardIndex = nil
                } else {
                    cards[offset].isFaceUp.toggle()
                    oldChoosenCardIndex = nil
                }
            } else {
                oldChoosenCardIndex = offset
                cards[offset].isFaceUp.toggle()
            }
        }
    
    mutating func shuffleCards() {
        cards.shuffle()
    }
    
    struct Card: Identifiable, Equatable {
        var id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
