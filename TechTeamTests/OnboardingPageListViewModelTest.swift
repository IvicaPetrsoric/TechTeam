//
//  OnboardingPageListViewModelTest.swift
//  TechTeamTests
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import XCTest
@testable import TechTeam

class OnboardingPageListViewModelTest: XCTestCase {
    
    var onboardingPageListViewModel: OnboardingPageListViewModel!
    let onboardingPage: [OnboardingPage] = [
        OnboardingPage(imageName: "ic_driver", title: "Driver", description: "Likes to drive car whole day"),
        OnboardingPage(imageName: "ic_car", title: "Car", description: "Car is red color")
    ]
    
    let index = 1
    var onboardingPageViewModel: OnboardingPageViewModel!
    
    override func setUp() {
        onboardingPageListViewModel = OnboardingPageListViewModel(onboardingPage)
        onboardingPageViewModel = onboardingPageListViewModel.getPageDataAt(index)
    }
    
    func test_onboardingListViewModelCount() {
        XCTAssertEqual(onboardingPageListViewModel.numberOfItemsInSection(), 2)
    }
    
    func test_onboardingListViewModelIcon() {
        XCTAssertEqual(onboardingPageViewModel.page.imageName, onboardingPage[index].imageName)
    }
    
    func test_onboardingListViewModelTitle() {
        XCTAssertEqual(onboardingPageViewModel.page.title, onboardingPage[index].title)
    }
       
    func test_onboardingListViewModelDescription() {
        XCTAssertEqual(onboardingPageViewModel.page.description, onboardingPage[index].description)
    }

}
