//
//  ImageDownloader.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import UIKit

class ImageDownloader: ObservableObject {

    @Published var downloadedData: UIImage = UIImage()
    
    func downloadImage(url: String) {
        APIManager.loadImage(endpointType: .getImage, imageName: url) { image in
            if let image = image, let cgimage = image.cgImage {
                let imageWidth = cgimage.height
                let offsetX = CGFloat(imageWidth)
                let image: UIImage = image.cropToBounds(image: image, width: imageWidth, height: imageWidth, offsetX: offsetX)
                
                DispatchQueue.main.async {
                    self.downloadedData = image
                }
            } else {
                DispatchQueue.main.async {
                    self.downloadedData = UIImage(named: "ic_launch") ?? UIImage()
                }
           }
        }
    }
    
}
