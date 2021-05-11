//
//  EmployeeDetailsFrontCard.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import SwiftUI

struct EmployeeDetailsFrontCard: View {
    
    var employeeViewModel: EmployeeViewModel
    
    init(employeeViewModel: EmployeeViewModel) {
        self.employeeViewModel = employeeViewModel
        self.imageDownloader.downloadImage(url: employeeViewModel.imageValue)
    }
    
    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()

    var body: some View {
         VStack {
            getTopCardPart()
            Spacer()
            getMidCardPart()
            Spacer()
            getBottomCardPart()
        }
        .frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.primaryColor), Color(.activeColor)]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(16)
    }
    
    private func getTopCardPart() -> some View {
        return HStack(alignment: .top) {
            Image(uiImage: self.imageDownloader.downloadedData)
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))

            Spacer()
            
            VStack(alignment: .trailing) {
                Text(employeeViewModel.departmentValue)
                    .foregroundColor(Color.white)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text(employeeViewModel.nameSurnameValue)
                    .foregroundColor(Color.white)
                    .font(.system(size: 18))
                    .fontWeight(.regular)
            }
        }
    }
    
    private func getMidCardPart() -> some View {
        return VStack {
            HStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundColor(Color.white.opacity(0.4))
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .center) {
                    Text(NSLocalizedString("EmployeeDetailsIntro", comment: ""))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)

                    Text(employeeViewModel.introValue)
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
    
    private func getBottomCardPart() -> some View {
        return HStack {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("EmployeeDetailsTitlo", comment: ""))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)

                Text(employeeViewModel.titleValue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(NSLocalizedString("EmployeeDetailsAgency", comment: ""))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                Text(employeeViewModel.agencyValue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct EmployeeDetailsFrontCard_Previews: PreviewProvider {
    static var previews: some View {
        let employee = Employee(department: "Test1", name: "Test2", surname: "Test3", image: "test4",
                                title: "test6", agency: "test8", intro: "test7", description: "test8")
        let viewModel = EmployeeViewModel(employee)
        
        Group {
            EmployeeDetailsFrontCard(employeeViewModel: viewModel)
            
        }
    }
}
