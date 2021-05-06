//
//  OnboardingCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 01/04/2021.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = OnboardingCollectionViewController(pagesData: OnboardingPage.allPages)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
