//
//  EmployeeViewModel.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation
import RxSwift

struct EmployeeViewModel {
    
    private var employee: Employee
    
    init(_ employee: Employee) {
        self.employee = employee
    }
    
    var nameValue: String {
        let name = employee.name ?? "Name"
        return name
    }
    
    var surnameValue: String {
        let surname = employee.surname ?? "Surname"
        return surname
    }
              
    var introValue: String {
        return employee.intro ?? "Intro"
    }
    
    var titleValue: String {
        return employee.title ?? "Title"
    }
    
    var agencyValue: String {
        if let agency = employee.agency {
            return agency.isEmpty ? "/" : "agency"
        }
        
        return "/"
    }
    
    var descriptionValue: String {
        return employee.description ?? "Description"
    }
    
    var imageValue: String {
        return employee.image ?? "Image"
    }
    
    var title: Observable<NSAttributedString> {
        let name = nameValue
        let surname = surnameValue
        
        let nameAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor
        ]
        
        let surnameAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.init(white: 0.7, alpha: 1)
        ]
        
        let attributedText = NSMutableAttributedString()
        let attributedNameText = NSAttributedString(string: name, attributes: nameAttributes)
        let attributedSurnameText = NSAttributedString(string: "\n\(surname)", attributes: surnameAttributes)
        attributedText.append(attributedNameText)
        attributedText.append(attributedSurnameText)
        
        return Observable<NSAttributedString>.just(attributedText)
    }
    
    var imageUrl: Observable<UIImage?> {
        return Observable<UIImage?>.create { observer in
            APIManager.loadImage(endpointType: .getImage, imageName: imageValue) { image in
                if let image = image, let cgimage = image.cgImage {
                    let imageWidth = cgimage.height
                    let image: UIImage = image.cropToBounds(image: image, width: imageWidth, height: imageWidth)
                    observer.onNext(image)
                } else {
                    observer.onNext(UIImage(named: "ic_launch"))
               }
            }
            
            return Disposables.create()
        }
    }

}
