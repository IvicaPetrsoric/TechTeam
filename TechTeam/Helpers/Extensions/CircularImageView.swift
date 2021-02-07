//
//  CircularImageView.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import UIKit

class CircularImageView: UIImageView {
    
//---
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = rect.width / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        if frame != .zero {
//            draw(frame)
//        }
    }
        
}


