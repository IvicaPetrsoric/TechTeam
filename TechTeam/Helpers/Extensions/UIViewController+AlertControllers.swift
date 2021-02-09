//
//  UIViewController+AlertControllers.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import UIKit

extension UIViewController {
    
    enum AlertMessage {
        case errorConnection
        
        func value() -> String {
            switch self {
            case .errorConnection:
                return NSLocalizedString("AlertConnectionErrorText", comment: "")
            }
        }
    }
    
    func showAllert(message: AlertMessage){
        let alert = UIAlertController(title: NSLocalizedString("AlertDialogTitle", comment: ""),
                                      message: message.value(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("AlertOkButtonText", comment: ""),
                                      style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


