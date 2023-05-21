//
//  Game.swift
//  SetGame
//
//  Created by Slava Rykov on 02.05.2023.
//

import SwiftUI

struct Game: View {
    private var viewModel = StandardSetGame()
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(viewModel.pile) { card in
                Card(card: card).aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding(.horizontal)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
