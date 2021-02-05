//
//  UIColor.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 04/02/2021.
//

import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    static let backgroundColor = UIColor.rgb(r: 10, g: 14, b: 33)
    
    static let activeColor = UIColor.rgb(r: 29, g: 30, b: 51)
    static let inactiveColor = UIColor.rgb(r: 17, g: 19, b: 40)
    
    static let primaryColor = UIColor.rgb(r: 235, g: 21, b: 85)
    static let primaryColorFaded = UIColor.rgb(r: 66, g: 26, b: 59)

}




////rgb(10, 14, 33)
//background primaryColor: Color(0xFF0A0E21),
//
////rgb(29, 30, 51)
//const kActiveCardColor = Color(0xFF1d1E33);
//
//
////rgb(17, 19, 40)
//const kInactiveCardColor = Color(0xFF111328);
//
//// rgb(235, 21, 85)
//const kBottomContainerColor = Color(0xFFEB1555);
