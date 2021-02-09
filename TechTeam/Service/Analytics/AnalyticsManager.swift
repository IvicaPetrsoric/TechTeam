//
//  EventService.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation

/// enable printig loggin events
let loggerDebugEnabled: Bool = true


struct UserProfileModel {
    var userID: String
}

protocol AnalyticsEventsLoggerProtocol {
    var user: UserProfileModel? {get set}
    func setUserProperties(user: UserProfileModel)
    func trackEvent(event: EventProtocol)
}

// Firebase
class FirebaseEventLogger: AnalyticsEventsLoggerProtocol {
    var user: UserProfileModel?
        
    // set user properties
    func setUserProperties(user: UserProfileModel) {
        self.user = user
        
        if loggerDebugEnabled {
            print("Setup: \(self)")
        }
    }
    
    // add implementation of tracking events
    func trackEvent(event: EventProtocol) {
        guard let user = user else { return }
        
        if loggerDebugEnabled {
            print("\(self) with userID \(user.userID)")
            print("Logg event \(event.name)")
            print("Logg event parramts \(event.params)")
            print("-----")
        }
    }
}

// setup any logger, FB, Google, Tutkija, etc.
class RandomEventLogger: AnalyticsEventsLoggerProtocol {
    
    var user: UserProfileModel?
        
    func setUserProperties(user: UserProfileModel) {}
    
    func trackEvent(event: EventProtocol) {}
    
}


class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private var loggers: [AnalyticsEventsLoggerProtocol] = []

    // Setup all the Analytics SDK
    func setUp() {
        let user = UserProfileModel(userID: UUID().uuidString)
        print("Analytic setup with userID \(user.userID)")

        let firebaseEventLogger = FirebaseEventLogger()
        firebaseEventLogger.setUserProperties(user: user)
        
        loggers.append(firebaseEventLogger)
    }
    
    func trackEvent(_ event: EventProtocol, params: [String: Any] = [:]) {
        loggers.forEach({ logger in
            logger.trackEvent(event: event)
        })
    }
}




