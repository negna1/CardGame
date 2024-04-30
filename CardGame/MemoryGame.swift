//
//  MemoryGame.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 30.04.24.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    var cards: [Card]
    
    init(numberOfPairsOfCard: Int, 
         cardFactory: (Int) -> (CardContent)) {
        cards = []
        for index in 0...(numberOfPairsOfCard - 1) {
            let content = cardFactory(index)
            let card = Card(id: "0\(content)", content: content)
            let card2 = Card(id: "1\(content)", content: content)
            cards.append(card)
            cards.append(card2)
        }
    }
    
    var oldChoosenCardIndex: Int?
    
    mutating func matchedContent(offset: Int) {
        guard let oldChoosenCardIndexWrapped = oldChoosenCardIndex else 
        { return }
        cards[oldChoosenCardIndexWrapped].isMatched = true
        cards[offset].isMatched = true
        cards[offset].isFaceUp = true
        oldChoosenCardIndex = nil
    }
    
    mutating func notMatchedContent(offset: Int) {
        cards[offset].isFaceUp = true
        oldChoosenCardIndex = nil
    }
    
    mutating func chooseCard(card: Card) {
        guard let (offset, _) = cards.enumerated().filter({$0.element == card}).first else { return }
        
        if oldChoosenCardIndex == offset {
            cards[offset].isFaceUp.toggle()
            oldChoosenCardIndex = nil
        }else if let oldChoosenCardIndexWrapped = oldChoosenCardIndex {
            cards[oldChoosenCardIndexWrapped].content == card.content ?
            matchedContent(offset: offset) :  notMatchedContent(offset: offset)
        } else {
            oldChoosenCardIndex = offset
            cards[offset].isFaceUp = true
        }
    }
    
    struct Card: Identifiable, Equatable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.id == rhs.id
        }
        
        var id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
    }
}
