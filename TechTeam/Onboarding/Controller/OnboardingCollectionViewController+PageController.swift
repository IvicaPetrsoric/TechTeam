//
//  OnboardingCollectionViewController+PageController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import Foundation

extension OnboardingCollectionViewController {

    func setupPageControllerView() {
        view.addSubviews(onboardinPageControllerView)
        
        onboardinPageControllerView.anchor(top: nil, leading: view.leadingAnchor,
                                           bottom: view.safeBottomAnchor, trailing: view.trailingAnchor,
                                           padding: .init(top: 0, left: 4, bottom: 44, right: 4),
                                           size: .init(width: 0, height: 50))
    }
    
    /// setup bindings on views buttons
    func setupOnboardingViewTapBindings() {
        onboardinPageControllerView.previousButton.rx.tap.bind { [weak self] in
            self?.handlePrev()
        }.disposed(by: disposeBag)
        
        onboardinPageControllerView.nextButton.rx.tap.bind { [weak self] in
            self?.handleNext()
        }.disposed(by: disposeBag)
        
        onboardinPageControllerView.eploreButton.rx.tap.bind { [weak self] in
            self?.handleExplore()
        }.disposed(by: disposeBag)
    }
    
    private func handlePrev(){
        let nextIndex = max(currentPageIndex - 1, 0)
        handleUpdatePageController(at: nextIndex, aniamteCollection: true)
    }
        
    private func handleNext(){
        let nextIndex = min(currentPageIndex + 1, onboardingPageListViewModel.numberOfItemsInSection())
        handleUpdatePageController(at: nextIndex, aniamteCollection: true)
    }
    
    private func handleExplore() {
        AnalyticsManager.shared.trackEvent(FeatureOneEvents.buttonClick,
                                          params:["extraKey": "extraValue"])
        
        let viewController = EmployeesCollectionViewController()
        let navController = CustomNavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func handleUpdatePageController(at index: Int, aniamteCollection: Bool) {
        currentPageIndex = index
        onboardinPageControllerView.updateControllerPosition(index: currentPageIndex)
        
        if aniamteCollection {
            let indexPath = IndexPath(item: currentPageIndex, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
