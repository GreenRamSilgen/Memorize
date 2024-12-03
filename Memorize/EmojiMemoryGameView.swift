//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kiran Shrestha on 11/5/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Text(viewModel.theme.name)
                    .font(.title)
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }
                
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
        }
        .foregroundStyle(viewModel.theme.getCurrentThemeColor())
        .padding()
    }
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 0)], spacing: 0) {
            ForEach (viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            }
        }
        .foregroundColor(viewModel.theme.getCurrentThemeColor())
        
        
    }
}

struct CardView : View {
    let card : MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 140))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
