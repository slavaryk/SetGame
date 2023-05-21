//
//  Card.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

struct Card: View {
    let card: SetGame.Card
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            
            cardShape.fill().foregroundColor(.white)
            cardShape.stroke(lineWidth: 3)
            
            ZStack { Figure(card: card) }
//            TODO: Add geometry reader dependency
            .frame(width: 60, height: 30)
            .foregroundColor(.orange)
        }
        .foregroundColor(.orange)
    }
    
    struct DrawingConstants {
        let CornerRadius = 20
        let StrokeWidth = 3
        
    }
}

struct Figure: Shape {
    let card: SetGame.Card
    let figureStrategy: FigureStrategy
    
    init(card: SetGame.Card) {
        self.card = card
        figureStrategy = Figure.chooseStrategy(card: card)
    }
    
    static func chooseStrategy(card: SetGame.Card) -> FigureStrategy {
        switch(card.shape) {
        case .first: return PillFigure()
        case .second: return RhombusFigure()
        case .third: return AmoebaFigure()
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return figureStrategy.buildPath(in: rect)
    }
}
