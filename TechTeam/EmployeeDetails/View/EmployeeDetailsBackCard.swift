//
//  EmployeeDetailsBackCard.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import SwiftUI

struct EmployeeDetailsBackCard: View {
    
    var employeeViewModel: EmployeeViewModel

    @State private var slideInTextSate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            getTitle()
            Spacer()
            getDescription()
            Spacer()
        }
        .frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.activeColor), Color(.primaryColor)]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(12)
    }
    
    private func getTitle() -> some View {
        return HStack(alignment: .top) {
            Spacer()

            VStack(alignment: .leading) {
                Text(NSLocalizedString("EmployeeDetailsDescription", comment: ""))
                    .foregroundColor(Color.gray)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .rotation3DEffect(.degrees(180),axis: (x: 0.0, y: 1.0, z: 0.0))
            }
        }
    }
    
    private func getDescription() -> some View {
        return ScrollView (showsIndicators: false) {
            Text(employeeViewModel.descriptionValue)
                .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                .foregroundColor(Color.white)
                .font(.system(size: 16))
                .offset(y: slideInTextSate ? 0 : 500)
                .animation(.interpolatingSpring(mass: 1.1, stiffness: 7, damping: 50, initialVelocity: 4))
                .onAppear {
                    slideInTextSate.toggle()
                }
        }
    }
    
}

struct EEmployeeDetailsBackCard_Previews: PreviewProvider {
    static var previews: some View {
        let employee = Employee(department: "Test1", name: "Test2", surname: "Test3", image: "test4",
                                title: "test6", agency: "test8", intro: "test7", description: "test8")
        let viewModel = EmployeeViewModel(employee)
        
        Group {
            EmployeeDetailsFrontCard(employeeViewModel: viewModel)
            
        }
    }
}
