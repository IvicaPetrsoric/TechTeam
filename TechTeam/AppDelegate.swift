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
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AnalyticsManager.shared.setUp()
        
//        window = UIWindow()
//        window?.makeKeyAndVisible()
//        window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
        
        let navController = CustomNavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        window = UIWindow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

}

