//
//  Pie.swift
//  Memoriza
//
//  Created by Laborit on 4/04/21.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool = false
//    MARK: Connect two animations with cards
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let radius  = min(rect.width, rect.height) / 2
        let center  = CGPoint(x: rect.midX, y: rect.midY)
        let start   = CGPoint( x: center.x + radius * cos(CGFloat(startAngle.radians)),
                               y: center.y + radius + sin(CGFloat(startAngle.radians))
                            )
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: clockWise
            )
        p.addLine(to: center)
        return p
    }
}
