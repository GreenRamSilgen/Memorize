//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/11/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    private(set) var cards : [Card]
    private(set) var score: Int = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach {
                if($0 == newValue) {
                    print("INDEX: \($0) isFaceUp: \(cards[$0].isFaceUp)")
                    print("newValue: \(newValue?.description ?? "nil")")
                    print("newValue == $0: \(newValue == $0)")
                    print("INDEX: \($0) isFaceUp: \(cards[$0].isFaceUp)... RESULT")
                }

                cards[$0].isFaceUp = (newValue == $0)
                if($0 == newValue) {
                    print("INDEX: \($0) isFaceUp: \(cards[$0].isFaceUp)... RESULT")
                }
            }
        }
    }
    
    init(maxEmojiInTheme: Int, numberOfParisOfCards: Int, cardContentFactory : (Int) -> CardContent) {
        cards = []
        let startingRange = Int.random(in: 0...maxEmojiInTheme-numberOfParisOfCards)
        let endRange = startingRange + numberOfParisOfCards
        
        for pairIndex in startingRange..<max(2,endRange) {
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)a"))
            cards.append(Card(content: cardContentFactory(pairIndex), id: "\(pairIndex)b"))
        }
        shuffle()
    }
    
    mutating func choose(_ card: Card) {
        print(card.debugDescription)
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp  && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    print("Checking for potential match now.")
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                        score += 2
                    }else {
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                            print("Lose point because of POTENTIAL MATCH \(cards[potentialMatchIndex].debugDescription)")
                        }else {
                            cards[potentialMatchIndex].hasBeenSeen = true
                        }
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                            print("Lose point because of CHOOSEN \(cards[chosenIndex].debugDescription)")
                        }else {
                            cards[chosenIndex].hasBeenSeen = true
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    print("Set the face up card.")
                }
                cards[chosenIndex].isFaceUp = true
            }
            

        }
        print(card.debugDescription)
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
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
