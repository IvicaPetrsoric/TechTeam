//
//  ViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 03/02/2021.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {

    private lazy var splashView = SplashView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .inactiveColor
        navigationController?.navigationBar.isHidden = true
                
        setupNotificationObservers()
        setupSplashView()
        setupObservers()
    }
    
    /// notifie if user leaves app, after re-entering make transition to next page
    private func setupNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationEnteringForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleNotificationEnteringForeground() {
        splashView.animateTransitionLayer()
    }
    
    private func setupSplashView() {
        view.addSubview(splashView)
        splashView.anchorFillSuperview()
    }
    
    /// observe when to transit to next screen
    private func setupObservers() {
        splashView
            .startTransitionOberver
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.startTransition()
            })
            .disposed(by: self.disposeBag)
    }

    @objc private func startTransition() {
        let viewController = OnboardingCollectionViewController(pagesData: OnboardingPage.allPages)
        navigationController?.pushViewController(viewController, animated: true)
    }

}



