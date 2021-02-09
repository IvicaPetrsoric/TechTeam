//
//  UIViewController+AlertControllers.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import UIKit

extension UIViewController {
    
    enum AlertMessage: String{
        case errorConnection = "Ooops, something went wrong, check your web connection and pull to refresh!"
    }
    
    func showAllert(message: AlertMessage){
        let alert = UIAlertController(title: "Notice", message: message.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
