//
//  ViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 03/02/2021.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {

    private lazy var splashView: SplashView = {
        let view = SplashView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .inactiveColor
        navigationController?.navigationBar.isHidden = true
        
        setupSplashView()
    }
    
    private func setupSplashView() {
        view.addSubview(splashView)
        splashView.anchorFillSuperview()
    }
    
    
    //    MARK:- TODO HANDLE BACKGROUND ANIMATIONS
        
    //    private func setupNotificationObservers(){
    //        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    //    }
    //
    //    // kada se ode u home da se aktivira ponovo anim
    //    @objc private func handleEnterForeground(){
    //        animatePuslingLayer()
    //    }
    //

    deinit {
        print("DEINIT SplashViewController")
    }
       
}

extension SplashViewController: SplashViewDelegate {
    
    func startTransition() {
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

