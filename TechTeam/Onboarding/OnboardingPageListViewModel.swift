//
//  OnboardingListViewModel.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import Foundation

class OnboardingPageListViewModel {
    
    private(set) var onboardingPagesViewModel: [OnboardingPageViewModel]

    init(_ pages: [OnboardingPage]) {
        self.onboardingPagesViewModel = pages.compactMap(OnboardingPageViewModel.init)
    }
    
    /// get number of sections
    func numberOfItemsInSection() -> Int {
        return onboardingPagesViewModel.count
    }
    
    /// page at specific index
    func getPageDataAt(_ index: Int) -> OnboardingPage {
        return onboardingPagesViewModel[index].page
    }
        
}

class OnboardingPageViewModel {
    
    var page: OnboardingPage
    
    init(_ page: OnboardingPage) {
        self.page = page
    }
    
}
