//
//  Strategy.swift
//  SetGame
//
//  Created by Slava Rykov on 20.05.2023.
//

import SwiftUI

protocol FigureStrategy {
    func buildPath(in rect: CGRect) -> Path
}

struct PillFigure: FigureStrategy {
    func buildPath(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.midX/2, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - rect.midX/2, y: rect.midY), radius: radius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + rect.midX/2, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + rect.midX/2, y: rect.midY), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: -90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct RhombusFigure: FigureStrategy {
    func buildPath(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: center.x, y: rect.minY))
        
        return path
    }
}

struct AmoebaFigure: FigureStrategy {
    func buildPath(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        
        var path = Path()
        
//        https://svg-to-swiftui.quassum.com/
        path.move(to: CGPoint(x: 0.81395*width, y: 0.06081*height))
        path.addCurve(to: CGPoint(x: 0.53101*width, y: 0.38514*height), control1: CGPoint(x: 0.70155*width, y: 0.16892*height), control2: CGPoint(x: 0.67442*width, y: 0.38514*height))
        path.addCurve(to: CGPoint(x: 0.08915*width, y: 0.06081*height), control1: CGPoint(x: 0.49096*width, y: 0.3491*height), control2: CGPoint(x: 0.20388*width, y: 0.21216*height))
        path.addCurve(to: CGPoint(x: 0.04651*width, y: 0.77027*height), control1: CGPoint(x: -0.05426*width, y: -0.12838*height), control2: CGPoint(x: 0.03876*width, y: 0.35811*height))
        path.addCurve(to: CGPoint(x: 0.43023*width, y: 0.77027*height), control1: CGPoint(x: 0.05426*width, y: 1.18243*height), control2: CGPoint(x: 0.35271*width, y: 0.91892*height))
        path.addCurve(to: CGPoint(x: 0.72093*width, y: 0.77027*height), control1: CGPoint(x: 0.50775*width, y: 0.62162*height), control2: CGPoint(x: 0.59302*width, y: 0.63514*height))
        path.addCurve(to: CGPoint(x: 0.99225*width, y: 0.28378*height), control1: CGPoint(x: 0.84884*width, y: 0.90541*height), control2: CGPoint(x: 1.0155*width, y: 0.47973*height))
        path.addCurve(to: CGPoint(x: 0.81395*width, y: 0.06081*height), control1: CGPoint(x: 0.96899*width, y: 0.08784*height), control2: CGPoint(x: 0.92636*width, y: -0.0473*height))
        path.closeSubpath()
        
        return path
    }
}
