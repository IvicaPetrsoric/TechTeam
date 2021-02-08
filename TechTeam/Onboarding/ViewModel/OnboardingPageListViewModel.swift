//
//  OnboardingListViewModel.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import Foundation
import RxSwift

struct OnboardingPageListViewModel {
    
    private var onboardingPagesViewModel: [OnboardingPageViewModel]

    init(_ pages: [OnboardingPage]) {
        self.onboardingPagesViewModel = pages.compactMap(OnboardingPageViewModel.init)
    }
    
    /// get number of sections
    func numberOfItemsInSection() -> Int {
        return onboardingPagesViewModel.count
    }
    
    /// page at specific index
    func getPageDataAt(_ index: Int) -> OnboardingPageViewModel {
        return onboardingPagesViewModel[index]
    }
            
}

struct OnboardingPageViewModel {
    
    private var page: OnboardingPage
    
    init(_ page: OnboardingPage) {
        self.page = page
    }
    
    var pageImage: Observable<UIImage> {
        let image = UIImage(named: page.imageName) ?? #imageLiteral(resourceName: "ic_launch")
        return Observable<UIImage>.just(image)
    }
    
    var pageTitle: Observable<String> {
        return Observable<String>.just(page.title)
    }
    
    var pageDescription: Observable<String> {
        let description = "\(page.description)"
        return Observable<String>.just(description)
    }
    
}

