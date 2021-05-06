//
//  SplashCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 01/04/2021.
//

import UIKit

class SplashCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SplashViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    // approach #1
//    func didFinishBuying() {
//        parentCoordinator?.childDidFinish(self)
//    }
    
    
}
