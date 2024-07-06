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
            let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.CornerRadius)
            let figure = Figure(card: card)
            
			cardShape.stroke(lineWidth: DrawingConstants.StrokeWidth).shadow(color: .black.opacity(0.5), radius: card.isSelected ? 2 : 0, y: 1).animation(.linear(duration: 0.1), value: card.isSelected)
			cardShape.fill().foregroundColor(card.isSelected ? .yellow.opacity(0.8) : .white).animation(.linear(duration: 0.1), value: card.isSelected)

            VStack {
				ForEach((1...figure.getQuantity()), id: \.self) { _ in
                    ZStack {
                        figure.fill(figure.getColor()).opacity(figure.getShadingOpacity())
                        figure.stroke(lineWidth: DrawingConstants.StrokeWidth).foregroundColor(figure.getColor())
                    }
                    .frame(width: DrawingConstants.FigureFrameWidth, height: DrawingConstants.FigureFrameHeight)
                }
            }
            
        }
        .foregroundColor(.black)
    }
    
    private struct DrawingConstants {
        static let CornerRadius = CGFloat(10)
        static let StrokeWidth = CGFloat(2)
        static let FigureFrameWidth = CGFloat(40)
        static let FigureFrameHeight = CGFloat(DrawingConstants.FigureFrameWidth/2)
    }
}

struct Figure: Shape {
    let card: SetGame.Card
    let shapeStrategy: ShapeStrategy
    let shadingStrategy: ShadingStrategy
    let colorStrategy: ColorStrategy
	let quantityStrategy: QuantityStrategy

    static private func chooseShapeStrategy(card: SetGame.Card) -> ShapeStrategy {
        switch(card.shape) {
        case .first: return PillShape()
        case .second: return RhombusShape()
        case .third: return AmoebaShape()
        }
    }
    
    static private func chooseShadingStrategy(card: SetGame.Card) -> ShadingStrategy {
        switch(card.shading) {
        case .first: return FilledShading()
        case .second: return TranslucentShading()
        case .third: return ClearShading()
        }
    }
    
    static private func chooseColorStrategy(card: SetGame.Card) -> ColorStrategy {
        switch(card.color) {
        case .first: return GreenColor()
        case .second: return BlueColor()
        case .third: return PinkColor()
        }
    }

	static private func chooseQuantityStrategy(card: SetGame.Card) -> QuantityStrategy {
		switch(card.quantity) {
		case .first: return QuantityOfOne()
		case .second: return QuantityOfTwo()
		case .third: return QuantityOfThree()
		}
	}

    init(card: SetGame.Card) {
        self.card = card
        shapeStrategy = Figure.chooseShapeStrategy(card: card)
        shadingStrategy = Figure.chooseShadingStrategy(card: card)
        colorStrategy = Figure.chooseColorStrategy(card: card)
		quantityStrategy = Figure.chooseQuantityStrategy(card: card)
    }
    
    func path(in rect: CGRect) -> Path { shapeStrategy.buildPath(in: rect) }
    
    func getShadingOpacity() -> CGFloat { shadingStrategy.getShadingOpacity() }
    
    func getColor() -> Color { colorStrategy.getColor() }

	func getQuantity() -> Int { quantityStrategy.getQuantity() }
}
