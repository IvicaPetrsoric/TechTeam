//
//  EventFeatures.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation

// FeatureOne
enum FeatureOneEvents {
    @Event(screenValue: "Onboarding")
    static var screen: Event

    @Event(clickValue: "FinishedWithOnboarindg")
    static var buttonClick: Event
}

