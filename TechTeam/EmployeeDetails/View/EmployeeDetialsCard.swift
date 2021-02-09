//
//  EmployeeDetialsCard.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import SwiftUI

struct EmployeeDetialsCard<Content>: View where Content: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
    }
}

