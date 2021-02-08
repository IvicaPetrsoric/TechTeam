//
//  EmployeeDetailsViewHostingController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit
import SwiftUI

class EmployeeDetailsViewHostingController: UIHostingController<EmployeeDetailsView> {
    
    init(viewModel: EmployeeViewModel) {
        super.init(rootView: EmployeeDetailsView(employeeViewModel: viewModel))
        rootView.dismiss = dismiss
        modalPresentationStyle = .overCurrentContext
        
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss() {
        rootView.dismiss = nil
        dismiss(animated: true) {
            self.removeFromParent()
            self.view.removeFromSuperview()
            
        }
    }
}
