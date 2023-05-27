//
//  ShapeStrategy.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

protocol ShapeStrategy {
    func buildPath(in rect: CGRect) -> Path
}

struct PillShape: ShapeStrategy {
    func buildPath(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        path.move(to: center)
        path.move(to: CGPoint(x: center.x, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.midX/2, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - rect.midX/2, y: rect.midY), radius: radius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + rect.midX/2, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + rect.midX/2, y: rect.midY), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: -90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct RhombusShape: ShapeStrategy {
    func buildPath(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        
        path.move(to: center)
        path.move(to: CGPoint(x: center.x, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: center.x, y: rect.minY))
        
        return path
    }
}

struct AmoebaShape: ShapeStrategy {
    func buildPath(in rect: CGRect) -> Path {
//      https://svg-to-swiftui.quassum.com/
        let width = rect.size.width
        let height = rect.size.height
        
        var path = Path()
        
        path.move(to: CGPoint(x: 0.99767*width, y: 0.13246*height))
        path.addCurve(to: CGPoint(x: 0.96814*width, y: 0.05351*height), control1: CGPoint(x: 0.99093*width, y: 0.10263*height), control2: CGPoint(x: 0.98116*width, y: 0.07544*height))
        path.addCurve(to: CGPoint(x: 0.84791*width, y: 0.06842*height), control1: CGPoint(x: 0.92535*width, y: -0.01754*height), control2: CGPoint(x: 0.88744*width, y: 0.01667*height))
        path.addCurve(to: CGPoint(x: 0.56302*width, y: 0.20526*height), control1: CGPoint(x: 0.76372*width, y: 0.17939*height), control2: CGPoint(x: 0.66651*width, y: 0.25088*height))
        path.addCurve(to: CGPoint(x: 0.39512*width, y: 0.08991*height), control1: CGPoint(x: 0.50488*width, y: 0.17982*height), control2: CGPoint(x: 0.45233*width, y: 0.12237*height))
        path.addCurve(to: CGPoint(x: 0.09977*width, y: 0.16667*height), control1: CGPoint(x: 0.29907*width, y: 0.03509*height), control2: CGPoint(x: 0.18279*width, y: 0.05*height))
        path.addCurve(to: CGPoint(x: 0.00884*width, y: 0.82281*height), control1: CGPoint(x: -0.00349*width, y: 0.3114*height), control2: CGPoint(x: -0.02558*width, y: 0.60219*height))
        path.addCurve(to: CGPoint(x: 0.04349*width, y: 0.94605*height), control1: CGPoint(x: 0.01581*width, y: 0.86798*height), control2: CGPoint(x: 0.02581*width, y: 0.91272*height))
        path.addCurve(to: CGPoint(x: 0.13651*width, y: 0.97544*height), control1: CGPoint(x: 0.0686*width, y: 0.99342*height), control2: CGPoint(x: 0.10465*width, y: 0.99825*height))
        path.addCurve(to: CGPoint(x: 0.29581*width, y: 0.80921*height), control1: CGPoint(x: 0.19372*width, y: 0.93202*height), control2: CGPoint(x: 0.23558*width, y: 0.84298*height))
        path.addCurve(to: CGPoint(x: 0.70279*width, y: 0.90482*height), control1: CGPoint(x: 0.43698*width, y: 0.72939*height), control2: CGPoint(x: 0.56047*width, y: 0.93465*height))
        path.addCurve(to: CGPoint(x: 0.94302*width, y: 0.66667*height), control1: CGPoint(x: 0.79465*width, y: 0.88596*height), control2: CGPoint(x: 0.88698*width, y: 0.80658*height))
        path.addCurve(to: CGPoint(x: 1.0093*width, y: 0.21667*height), control1: CGPoint(x: 0.99465*width, y: 0.53772*height), control2: CGPoint(x: 1.02*width, y: 0.37851*height))
        path.addCurve(to: CGPoint(x: 0.99767*width, y: 0.13246*height), control1: CGPoint(x: 1.00767*width, y: 0.18816*height), control2: CGPoint(x: 1.00395*width, y: 0.15921*height))
        path.closeSubpath()
        
        return path
    }
}
