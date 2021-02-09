//
//  OnboardingPage.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import Foundation

struct OnboardingPage {
    
    var imageName: String
    var title: String
    var description: String
}

extension OnboardingPage {
    
    static let emptyPage: OnboardingPage = OnboardingPage(imageName: "", title: "", description: "")
    
    static let allPages: [OnboardingPage] = [
        .init(imageName: "ic_who_are_we",
              title: NSLocalizedString("PageDataTitle_0", comment: ""),
              description: NSLocalizedString("PageDataDescription_0", comment: "")),
        .init(imageName: "ic_we_do",
            title: NSLocalizedString("PageDataTitle_1", comment: ""),
            description: NSLocalizedString("PageDataDescription_1", comment: "")),
        .init(imageName: "ic_culture",
            title: NSLocalizedString("PageDataTitle_2", comment: ""),
            description: NSLocalizedString("PageDataDescription_2", comment: "")),
        .init(imageName: "ic_experience",
            title: NSLocalizedString("PageDataTitle_3", comment: ""),
            description: NSLocalizedString("PageDataDescription_3", comment: "")),
        .init(imageName: "ic_meet_team",
            title: NSLocalizedString("PageDataTitle_4", comment: ""),
            description: NSLocalizedString("PageDataDescription_4", comment: "")),
    ]
}

