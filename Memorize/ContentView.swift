//
//  ContentView.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/5/24.
//

import SwiftUI

struct ContentView: View {
    let sportsEmojis : [String]
    let carEmojis: [String]
    let foodEmojis : [String]
    let selectableThemes : [[String]]
    
    init() {
        sportsEmojis = ["⚽️", "⚽️", "🏀", "🏀", "🏈", "🏈", "⚾️", "⚾️", "🎾", "🎾", "🏐", "🏐", "🏉", "🏉", "🎱", "🎱", "🏓", "🏓", "⛳️", "⛳️"]
        carEmojis = ["🚗", "🚗", "🚕", "🚕", "🚙", "🚙", "🚌", "🚌", "🚎", "🚎", "🏎️", "🏎️", "🚓", "🚓", "🚑", "🚑", "🚒", "🚒", "🚐", "🚐", "🚚", "🚚", "🚛", "🚛", "🚜", "🚜", "🚍", "🚍", "🚘", "🚘"]
        foodEmojis = ["🍩", "🍩", "🍪", "🍪"]
        selectableThemes = [sportsEmojis, carEmojis, foodEmojis]
    }
    @State var cardCount : Int = 4
    @State var selectedTheme : Int = 1
    
    var body: some View {
        VStack{
            Text("Memorize").font(.largeTitle)
            themeSelector
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var themeSelector : some View {
        HStack{
            Text("Select Theme: ")
                .font(.title2)
            ForEach(0..<selectableThemes.count, id: \.self) { themeIdx in
                themeButton(idx: themeIdx)
            }
        }
    }
    func themeButton(idx: Int) -> some View {
        Button(action: {
            selectedTheme = idx
            if cardCount > selectableThemes[idx].count {
                cardCount = selectableThemes[idx].count
            }
            
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 2)
                Text(selectableThemes[idx].first!)
                
            }
            .frame(width: 50, height: 50)
            
        })
    }
    
    
    var cards : some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach (0..<cardCount, id: \.self) { idx in
                CardView(content: selectableThemes[selectedTheme][idx], isFaceUp: false)
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        
    }
    var cardCountAdjusters : some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount+offset < 1 || cardCount+offset > selectableThemes[selectedTheme].count)
    }
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder : some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView : View {
    let content : String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
