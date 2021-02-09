//
//  EmployeeDetailsView.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import UIKit
import SwiftUI

struct EmployeeDetailsView: View {
    
    var dismiss: (() -> Void)?
    
    var employeeViewModel: EmployeeViewModel
    
    @State private var degrees: Double = 0
    @State private var flipped: Bool = false
    @State private var slideInCardState: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(slideInCardState ? 0.7 : 0)
                .animation(.default)
                .onTapGesture {
                    slideInCardState.toggle()
                    removeView()
                }

            VStack  {
                Spacer()
                EmployeeDetialsCard {
                    VStack {
                        Group {
                            if flipped {
                                EmployeeDetailsBackCard(employeeViewModel: employeeViewModel)
                            } else {
                                EmployeeDetailsFrontCard(employeeViewModel: employeeViewModel)
                            }
                        }
                    }
                    .rotation3DEffect(.degrees(degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .opacity(slideInCardState ? 1 : 0)
                    .offset(y: slideInCardState ? 0 : -700)
                    .animation(.interpolatingSpring(mass: 1.1, stiffness: 7, damping: 50, initialVelocity: 4))
                    .onAppear {
                        startAnimationWithDelay()
                    }
                }.onTapGesture {
                    withAnimation {
                        degrees += 180
                        flipped.toggle()
                    }
                }
                
                Spacer()
                
            }
        }
    }
    
    private func startAnimationWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            slideInCardState.toggle()
        }
    }
    
    private func removeView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dismiss?()
        }
    }
    
}


struct EmployeeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let employee = Employee(department: "Test1", name: "Test2", surname: "Test3", image: "test4",
                                title: "test6", agency: "test8", intro: "test7", description: "test8")
        let viewModel = EmployeeViewModel(employee)
        
        Group {
            EmployeeDetailsView(employeeViewModel: viewModel)
        }
    }
}
