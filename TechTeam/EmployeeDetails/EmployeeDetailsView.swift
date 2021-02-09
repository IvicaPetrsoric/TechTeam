//
//  EmployeeDetailsView.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import UIKit
import SwiftUI

class ImageDownloader: ObservableObject {

    @Published var downloadedData: UIImage = UIImage()
    
    func downloadImage(url: String) {
        
        print(url)
        
        guard let imageURL = URL(string: "https://teltech.co/images/members/\(url).jpg") else {
            fatalError("ImageURL is incorrect")
        }
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: imageURL)
            print(data)
            let image2: UIImage = UIImage(data: data)!
            let width = image2.cgImage!.height

            let image3: UIImage = image2.cropToBounds(image: image2, width: width, height: width, offsetX: CGFloat(width))

            
            DispatchQueue.main.async {
                self.downloadedData = image3
            }
        }
    }
    
}


struct EmployeeDetailsView: View {
    
    var dismiss: (() -> Void)?
    
    var employeeViewModel: EmployeeViewModel
    
    @State private var degrees: Double = 0
    @State private var flipped: Bool = false
    @State private var slideInTextSate: Bool = false
    
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(slideInTextSate ? 0.7 : 0)
                .animation(.default)
                .onTapGesture {
                    slideInTextSate.toggle()
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
                    }.rotation3DEffect(
                        .degrees(degrees),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .opacity(slideInTextSate ? 1 : 0)
                    .offset(y: slideInTextSate ? 0 : -700)
                    .animation(.interpolatingSpring(mass: 1.1, stiffness: 7, damping: 50, initialVelocity: 4))
                    .onAppear {
                        delayText()
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
    
    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            slideInTextSate.toggle()
        }
    }
    
    private func removeView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dismiss?()

        }
    }
    
}

struct EmployeeDetialsCard<Content>: View where Content: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
    }
}

struct UIKLabel: UIViewRepresentable {

    typealias TheUIView = UILabel
    fileprivate var configuration = { (view: TheUIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> TheUIView { TheUIView() }
    func updateUIView(_ uiView: TheUIView, context: UIViewRepresentableContext<Self>) {
        uiView.numberOfLines = 0
        configuration(uiView)
    }
}

struct EmployeeDetailsFrontCard: View {
    
    var employeeViewModel: EmployeeViewModel {
        didSet {

        }
    }
    
    
    
    init(employeeViewModel: EmployeeViewModel) {
        self.employeeViewModel = employeeViewModel
        self.imageDownloader.downloadImage(url: employeeViewModel.imageValue)

    }
    
    @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()

    func fetchImage() {
    }
    
    var body: some View {
        
        
    
        VStack {
            HStack(alignment: .top) {
                Image(uiImage: self.imageDownloader.downloadedData)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))

                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(employeeViewModel.nameValue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Text(employeeViewModel.surnameValue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                }
//                Spacer()

            }
            
                    Spacer()

            
            HStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundColor(Color.white.opacity(0.4))
            }
            
            Spacer()

            HStack {
                VStack(alignment: .center) {
                    Text("Intro")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)

                    Text(employeeViewModel.introValue)
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                }
            }

            Spacer()

            HStack {
                VStack(alignment: .leading) {
                    Text("Title")
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
                    Text("Agency")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                    Text(employeeViewModel.agencyValue)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
            }
            
        }.frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.primaryColor), Color(.activeColor)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(16)
        .onAppear {
            fetchImage()
        }
    }
}

struct EmployeeDetailsBackCard: View {
    
    @State private var slideInTextSate: Bool = false
    var employeeViewModel: EmployeeViewModel

    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                Spacer()

                VStack(alignment: .leading) {
                    Text("Descrption")
                        .foregroundColor(Color.white)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: (x: 0.0, y: 1.0, z: 0.0))
                    
                }

            }
            Spacer()
            
            ScrollView (showsIndicators: false) {
                Text(employeeViewModel.descriptionValue)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0))
                    .foregroundColor(Color.white)
                    .font(.system(size: 12))
                    .offset(y: slideInTextSate ? 0 : 500)
                    .animation(.interpolatingSpring(mass: 1.1, stiffness: 7, damping: 50, initialVelocity: 4))
                    .onAppear {
                        slideInTextSate.toggle()
                    }

            }

            Spacer()

        }.frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.activeColor), Color(.primaryColor)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(12)
    }
    
}

struct EmployeeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmployeeViewModel(Employee(department: "Test1", name: "Test2", surname: "Test3", image: "test4", title: "test6", agency: "test8", intro: "test7", description: "test8"))
        Group {
            EmployeeDetailsView(employeeViewModel: viewModel)
            
        }
    }
}
