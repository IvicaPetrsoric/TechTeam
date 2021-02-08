//
//  delay.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import Foundation

func delay(_ delay:Double, closure: @escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}
