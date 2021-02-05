//
//  CircularShapeLayer.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 04/02/2021.
//

import UIKit

extension UIView {
    
    func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor,
                                radius: CGFloat = 100, lineWidth: CGFloat = 10) -> CAShapeLayer{
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius,
                                        startAngle:  0, endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        return layer
    }
    
}
