//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/11/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    private(set) var cards : [Card]
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    init(numberOfParisOfCards: Int, cardContentFactory : (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfParisOfCards) {
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)a"))
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp  && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                        self.indexOfTheOneAndOnlyFaceUpCard = nil
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            

        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        var id: String
        var debugDescription: String {
            "\(id) \(content) \(isFaceUp ? "face up" : "face down") \(isMatched ? "matched" : "not matched")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
