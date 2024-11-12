//
//  ContentView.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/5/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    let sportsEmojis : [String]
    let carEmojis: [String]
    let foodEmojis : [String]
    let selectableThemes : [([String],String,Color)]
    let themeNames : [String] = ["Sports", "Cars", "Food"]
    
    init() {
        sportsEmojis = ["⚽️", "⚽️", "🏀", "🏀", "🏈", "🏈", "⚾️", "⚾️", "🎾", "🎾", "🏐", "🏐", "🏉", "🏉", "🎱", "🎱", "🏓", "🏓", "⛳️", "⛳️"]
        carEmojis = ["🚗", "🚗", "🚕", "🚕", "🚙", "🚙", "🚌", "🚌", "🚎", "🚎", "🏎️", "🏎️", "🚓", "🚓", "🚑", "🚑", "🚒", "🚒", "🚐", "🚐", "🚚", "🚚", "🚛", "🚛", "🚜", "🚜", "🚍", "🚍", "🚘", "🚘"]
        foodEmojis = ["🍩", "🍩", "🍪", "🍪"]
        selectableThemes = [(sportsEmojis, "Sports", Color.orange), (carEmojis, "Cars", Color.blue), (foodEmojis, "Food", Color.green)]
    }
    @State var cardCount : Int = 0
    @State var selectedTheme : Int = -1
    @State var currentUsedTheme : [String] = ["⚽️", "🚗", "🍩", "⚽️"]
    @State var currentColor : Color = .orange
    
    var body: some View {
        VStack{
            Text("Memorize").font(.largeTitle)
            
            ScrollView{
                cards
            }
            Spacer()
            themeSelector
                .font(.subheadline)
        }
        .foregroundStyle(selectedTheme == -1 ? .purple : currentColor)
        .padding()
    }
    
    var themeSelector : some View {
        HStack{
            ForEach(0..<selectableThemes.count, id: \.self) { themeIdx in
                themeButton(idx: themeIdx)
            }
        }
    }
    func themeButton(idx: Int) -> some View {
        Button(action: {
            selectedTheme = idx
            cardCount = Array(stride(from: 2, to: selectableThemes[idx].0.count+1, by: 2)).randomElement()!
            currentUsedTheme = selectableThemes[idx].0.shuffled()
            currentColor = selectableThemes[idx].2
            print(cardCount)
        }, label: {
            if selectedTheme == idx {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill()
                    VStack{
                        Text(selectableThemes[idx].0.first!)
                        Text(selectableThemes[idx].1)
                    }
                    .foregroundStyle(.white)
                }
                .frame(width: 50, height: 50)
            }else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(lineWidth: 2)
                    VStack{
                        Text(selectableThemes[idx].0.first!)
                        Text(selectableThemes[idx].1)
                    }
                }
                .frame(width: 50, height: 50)
            }
            
        })
    }
    
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: CGFloat(cardCount <= 4 ? 100 : 150/(cardCount/6))))]) {
                ForEach (0..<cardCount, id: \.self) { idx in
                    CardView(content: currentUsedTheme[idx], isFaceUp: false)
                        .aspectRatio(2/3,contentMode: .fit)
                }
            }
            .foregroundColor(currentColor)
        
        
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
    EmojiMemoryGameView()
}
