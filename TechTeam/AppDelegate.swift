//
//  AppDelegate.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 03/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
//        window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
//        return true
        
        let viewController = OnboardingCollectionViewController(pagesData: OnboardingPage.allPages)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        let viewController2 = EmployeesCollectionViewController()
        let navController = CustomNavigationController(rootViewController: viewController2)
        navController.modalPresentationStyle = .fullScreen
        viewController.present(navController, animated: true)
        return true
    }


}

