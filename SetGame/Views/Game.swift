//
//  Game.swift
//  SetGame
//
//  Created by Slava Rykov on 02.05.2023.
//

import SwiftUI

struct Game: View {
    let addCardsButtonText = "More cards"
    
    @ObservedObject private var viewModel = StandardSetGame()
    
    var body: some View {
        VStack(spacing: 30.0) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.pile) { card in
                        Card(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.toggleCardSelection(cardId: card.id)
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            GameButton { Text(addCardsButtonText) }
            action: { viewModel.addExtraCards() }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
