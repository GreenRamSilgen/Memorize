//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/11/24.
//

import SwiftUI
// View Model
class EmojiMemoryGame : ObservableObject {
    //TODO: Remove emojis and use the Theme's Emojis instead
    //private static let emojis = ["👻", "🎃", "🤖", "👽", "💀", "☠️"]
    private static func createMemoryGame(withTheme currentTheme : ThemeManager.Theme = ThemeManager.themes.first!) -> MemoryGame<String> {
        return MemoryGame(maxEmojiInTheme: currentTheme.emojis.count, numberOfParisOfCards: currentTheme.numberOfPairs) { pairIndex  in
            if currentTheme.emojis.indices.contains(pairIndex) {
                return currentTheme.emojis[pairIndex]
            }else {
                return "‼️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    @Published private var themeModel = ThemeManager()
    var cards : Array<MemoryGame<String>.Card>{
        model.cards
    }
    var theme : ThemeManager.Theme {
        themeModel.currentTheme
    }
    
    func newGame() {
        themeModel.changeToRandomTheme()
        model = EmojiMemoryGame.createMemoryGame(withTheme: themeModel.currentTheme)
    }
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
