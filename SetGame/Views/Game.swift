//
//  Game.swift
//  SetGame
//
//  Created by Slava Rykov on 02.05.2023.
//

import SwiftUI

struct Game: View {
    private let addCardsButtonText = "More cards"
    
    @ObservedObject private var viewModel = StandardSetGame()
    
    var body: some View {
        VStack(spacing: 30.0) {
			GeometryReader { geometry in
				ScrollView {
					LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.size.width/7))]) {
						ForEach(viewModel.pile) { card in
							Card(card: card).aspectRatio(2/3, contentMode: .fill)
								.onTapGesture {
									viewModel.toggleCardSelection(cardId: card.id)
								}
						}
					}
					.padding(.horizontal)
					.padding(.bottom)
				}
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
