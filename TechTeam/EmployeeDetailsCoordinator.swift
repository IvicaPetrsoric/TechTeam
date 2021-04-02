//
//  EmployeeDetailsCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 02/04/2021.
//

import UIKit

class EmployeeDetailsCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func start(viewModel: EmployeeViewModel) {
        let hostingViewController = EmployeeDetailsViewHostingController(viewModel: viewModel)
        navigationController.present(hostingViewController, animated: true)
        return
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.rootViewController?.present(hostingViewController, animated: true)
        }

    }
    
}



