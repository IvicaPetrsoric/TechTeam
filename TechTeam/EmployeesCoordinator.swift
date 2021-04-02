//
//  EmployeesCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 01/04/2021.
//

import UIKit

class EmployeesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController2: CustomNavigationController
    
    init(navigationController: CustomNavigationController) {
        self.navigationController = navigationController
        self.navigationController2 = navigationController
    }
    
    func start() {
        let viewController = EmployeesCollectionViewController()
        let navController = CustomNavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        viewController.coordinator = self
//        navigationController2.pushViewController(viewController, animated: true)
//        return
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.rootViewController?.present(navController, animated: true)
        }
        
//        navigationController.viewControllers.first?.present(navController, animated: true)
    }
    
}
