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
    
    static let allPages: [OnboardingPage] = [
        .init(imageName: "ic_who_are_we",
              title: "Who are we?",
              description: "Teltech is a New Jersey based communications company and a proud part of IAC. Headquartered just a short distance from New York City"),
        .init(imageName: "ic_we_do",
              title: "What do we do?",
              description: "We bring bright\nideas to life"),
        .init(imageName: "ic_culture",
              title: "how we encourage success?",
              description: "We foster a unique and diverse Silicon Valley-like culture, where talented individuals can flourish"),
        .init(imageName: "ic_experience",
              title: "What is our strength?",
              description: "Our deep wealth of experience in telecom and mobile allows us to execute fresh new ideas and opportunities that other companies wouldn't have the foresight to see"),
        .init(imageName: "ic_meet_team",
              title: "Who makes our company?",
              description: "A highly motivated team who strives giving the end user what they want, even if they don't know it yet"),
    ]
}

