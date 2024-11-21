struct ThemeManager {
    var currentTheme : Theme
    var themes : [Theme]
    
    func nextTheme() {
        
    }
    
    mutating func addTheme(_ theme : Theme) {
        themes.append(theme)
    }
}

struct Theme {
    let theme : String
    let emoji : [String]
    var numberOfPairs : Int
    var color : String
    
}