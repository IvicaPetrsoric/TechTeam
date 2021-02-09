//
//  Event.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import Foundation

protocol EventProtocol {
    var name: String { get set }
    var params: [String: Any] { get set }
}

@propertyWrapper
struct Event: EventProtocol {
    var name: String
    var params: [String: Any] = [:]

    var wrappedValue: Event {
        return Event(name: name,
                     params: params)
    }
}

extension Event {
    init(screenValue: String) {
        self.init(name: EventName.screenVisit,
                  params: [ParameterName.screen: screenValue])
    }

    init(clickValue: String) {
        self.init(name: EventName.clickEvent,
                  params: [ParameterName.click: clickValue])
    }
}

enum EventName {
    static let screenVisit = "Screen Visit"
    static let clickEvent = "Click Event"
}

enum ParameterName {
    static let screen = "screen_name"
    static let click = "click_target"
}
