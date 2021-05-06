//
//  MainCoordinator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 01/04/2021.
//

//import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        navigateToSplashViewController()
    }
    
    func navigateToSplashViewController() {
        childDidFinish(childCoordinators.first)
        
        let child = SplashCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func navigateToOnboardingViewController() {
        childDidFinish(childCoordinators.first)

        let child = OnboardingCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func navigateToEmployeesViewController() {
        childDidFinish(childCoordinators.first)

        let child = EmployeesCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func navigateToEmployeesDetailsViewController(viewModel: EmployeeViewModel) {
//        childDidFinish(childCoordinators.first)

        let child = EmployeeDetailsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(viewModel: viewModel)
    }
        
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    // automatically see when back button is pressed, used to remove chilc coordinator
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        // adding another
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
//        if let splashViewController = fromViewController as? SplashViewController {
//            childDidFinish(splashViewController.coordinator)
//        }
    }
}
