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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.navigationController2 = CustomNavigationController()
    }
    
    func start() {
        let viewController = EmployeesCollectionViewController()
        let navController = CustomNavigationController(rootViewController: viewController)
//        navController.modalPresentationStyle = .fullScreen
        viewController.coordinator = self
        
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
