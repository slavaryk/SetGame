//
//  Game.swift
//  SetGame
//
//  Created by Slava Rykov on 02.05.2023.
//

import SwiftUI

struct Game: View {
    private static let ADD_CARDS_BUTTON_TEXT = "More cards"

	@ObservedObject private var viewModel: StandardSetGame

	init(isContinue: Bool) {
		viewModel = StandardSetGame(isContinue: isContinue)
	}

    var body: some View {
        VStack(spacing: 30.0) {
			GeometryReader { geometry in
				ScrollView {
					LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.size.width/7))]) {
						ForEach(viewModel.pile) { card in
							SetCard(card: card).aspectRatio(2/3, contentMode: .fill)
								.onTapGesture {
									viewModel.toggleCardSelection(cardId: card.id)
								}
						}
					}
					.padding(.horizontal)
					.padding(.bottom)
				}
			}

			GameButton { Text(Game.ADD_CARDS_BUTTON_TEXT) }
            action: { viewModel.addExtraCards() }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Game(isContinue: false)
    }
}
