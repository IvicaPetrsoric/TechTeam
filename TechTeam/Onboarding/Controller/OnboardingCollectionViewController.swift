//
//  OnboardingViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit
import RxCocoa
import RxSwift

final class OnboardingCollectionViewController: UICollectionViewController {
    
    weak var coordinator: OnboardingCoordinator?
    
    private(set) var onboardingPageListViewModel = OnboardingPageListViewModel([])
        
    private(set) lazy var onboardinPageControllerView =
        OnboardinPageControllerView(viewModel: onboardingPageListViewModel)
       
    let cellId = "cellId"
    var currentPageIndex = 0

    let disposeBag = DisposeBag()
    
    init(pagesData: [OnboardingPage]) {
        onboardingPageListViewModel = OnboardingPageListViewModel(pagesData)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        AnalyticsManager.shared.trackEvent(FeatureOneEvents.screen)
        
        setupCollectionView()
        setupPageControllerView()
        setupOnboardingViewTapBindings()
    }
    
}

