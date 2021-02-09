//
//  UIImage+Crop.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import UIKit

extension UIImage {
    
    
    func cropToBounds(image: UIImage, width: Int, height: Int, offsetX: CGFloat = 0) -> UIImage {
        guard let cgimage = image.cgImage else {
            return UIImage(named: "ic_launch") ?? UIImage()
        }
            
        let posX: CGFloat = offsetX
        let posY: CGFloat = 0.0
        let cgwidth: CGFloat = CGFloat(width)
        let cgheight: CGFloat = CGFloat(height)

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
    
}
