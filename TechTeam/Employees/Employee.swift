//
//  Employee.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import Foundation

struct Employee: Decodable {
    
    var department: String
    var name: String
    var surname: String
    var image: String
    var title: String
    var agency: String
    var intro: String
    var description: String
}

