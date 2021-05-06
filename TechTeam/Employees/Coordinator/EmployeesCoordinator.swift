//
//  EmployeesCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 01/04/2021.
//

import UIKit

class EmployeesCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
           
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = EmployeesCollectionViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
