//
//  ThemeManager.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/20/24.
//

import SwiftUICore


struct ThemeManager {
    private(set) var currentTheme : Theme = themes.first!
    static var themes : [Theme] = [
        Theme(name: "Countries", emojis: ["🇺🇸", "🇨🇦", "🇬🇧", "🇫🇷", "🇩🇪", "🇮🇳", "🇯🇵", "🇦🇺"], numberOfPairs: 2, color: "Blue"),
        Theme(name: "Spooky", emojis: ["🎃", "👻", "🕷️", "🦇"], numberOfPairs: 3, color: "Orange"),
        Theme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🎳", "🏓"], numberOfPairs: 5, color: "Yellow"),
        Theme(name: "Food", emojis: ["🍎", "🍔", "🍕", "🍣", "🍩", "🌮", "🍪", "🍓"], numberOfPairs: 6, color: "Brown"),
        Theme(name: "Vehicle", emojis: ["🚗", "🚎", "🛻", "🚓", "🚞", "🚡", "🚢", "🚣"], numberOfPairs: 6, color: "Purple"),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦇", "🐻", "🐼"], numberOfPairs: 4, color: "")
    ]
    
    mutating func changeToRandomTheme() {
        currentTheme = ThemeManager.themes.randomElement()!
    }
    
    static func addTheme(_ theme : Theme) {
        themes.append(theme)
    }
    
    struct Theme {
        let name : String
        let emojis : [String]
        var numberOfPairs : Int
        var color : String
        
        func getCurrentThemeColor() -> Color {
            switch color {
            case "Orange":
                return .orange
            case "Green":
                return .green
            case "Brown":
                return .brown
            case "Blue":
                return .blue
            case "Purple":
                return .purple
            case "Yellow":
                return .yellow
            default:
                return .red
            }
        }
    }
}


