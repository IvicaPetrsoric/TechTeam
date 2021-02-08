//
//  EmployeeListViewModel.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct EmployeeListViewModel {
    
    private let selectedPhotoSubject = PublishSubject<Bool>()
    var selectedPhoto: Observable<Bool> {
        return selectedPhotoSubject.asObservable()
    }
    
    var isLoadingData: Driver<Bool>?
    let disposeBag = DisposeBag()
    
    private var employeesViewModel: [EmployeeViewModel]
    
    init(_ employees: [Employee]) {
        self.employeesViewModel = employees.compactMap(EmployeeViewModel.init)
        

        print("toster")
//        sleep(2)
//        selectedPhotoSubject.on(.next(true))
        

        if employees.count != 0 {
//            isLoadingData?.
            

                
        }
    }
    
    private func fetchData() {
        selectedPhotoSubject.onNext(true)
    }
    
    /// get number of sections
    func numberOfItemsInSection() -> Int {
        if employeesViewModel.count > 0 {
            print("FIRE")
            selectedPhotoSubject.onNext(true)

//            isLoadingData?.asObservable().ju
//            isLoadingData?.asObservable().onNext(true)
//                selectedPhotoSubject.onNext(true)
//            selectedPhotoSubject.on
        }
        return employeesViewModel.count
    }
    
    /// page at specific index
    func getEmployeeAt(_ index: Int) -> EmployeeViewModel {
        return employeesViewModel[index]
    }

}

struct EmployeeViewModel {
    
    private var employee: Employee
    
    init(_ employee: Employee) {
        self.employee = employee
    }
    
    var nameValue: String {
        let name = employee.name
        return name
    }
    
    var surnameValue: String {
        let surname = employee.surname
        return surname
    }
           
    var nameSurnameValue: String {
        let name = employee.name
        let surname = employee.surname
        return "\(name) \(surname)"
    }
    
    var introValue: String {
        return employee.intro
    }
    
    var titleValue: String {
        return employee.title
    }
    
    var agencyValue: String {
        if let agency = employee.agency {
            return agency.isEmpty ? "/" : "agency"
        }
        
        return "/"
    }
    
    var descriptionValue: String {
        return employee.description
    }
    
    var imageValue: String {
        return employee.image
    }
    
//    var imageValue: UIImage
//    
//    func getImage() -> UIImage {
//        return imageValue
//    }
    
    var title: Observable<NSAttributedString> {
        let name = employee.name
        let surname = employee.surname
        
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
    
//    var imageUrl: Observable<UIImage> {
//        let imageUrl = loadImage(fromURL: employee.image) { (image) in
//            <#code#>
//        }
//        return Observable<UIImage>.just()
//    }
    
    var imageUrl: Observable<UIImage?> {
//        guard let imageURL = URL(string: "https://teltech.co/images/members/\(employee.image).jpg") else {
//            return Observable<UIImage?>.just(nil)
//        }
//
//        let cache =  URLCache.shared
//        let request = URLRequest(url: imageURL)
//
//        return loadImage(url: imageURL)
        
        return Observable<UIImage?>.create { observer in
            self.loadImage(fromURL: "https://teltech.co/images/members/\(employee.image).jpg") { image in
                let width = image.cgImage!.height
                let image2: UIImage = EmployeeViewModel.cropToBounds(image: image, width: width, height: width)
//                self.imageValue = image2
                observer.onNext(image2)
//                observer.onNext(cropToBounds(image: image, width: image.cgImage.w, height: 200))
            }
            
            return Disposables.create()
        }

        

    }
    
    static func cropToBounds(image: UIImage, width: Int, height: Int, offsetX: CGFloat = 0) -> UIImage {
            let cgimage = image.cgImage!
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            var posX: CGFloat = offsetX
            var posY: CGFloat = 0.0
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)

            // See what size is longer and create the center off of that
//            if contextSize.width > contextSize.height {
//                posX = ((contextSize.width - contextSize.height) / 2)
//                posY = 0
//                cgwidth = contextSize.height
//                cgheight = contextSize.height
//            } else {
//                posX = 0
//                posY = ((contextSize.height - contextSize.width) / 2)
//                cgwidth = contextSize.width
//                cgheight = contextSize.width
//            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = cgimage.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation
            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

            return image
        }
    
    func loadImage(url: URL) -> Observable<UIImage?> {
        return Observable.just(url)
            .flatMap { url -> Observable<(Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { (data) -> UIImage? in
                return UIImage(data: data)
            }
    }
    
    

    
    func loadImage(fromURL url: String, completiong: @escaping((UIImage) -> Void)) {
        guard let imageURL = URL(string: url) else {
            completiong(UIImage())
            return
        }

        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completiong(image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            completiong(image)
//                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    
    
}

