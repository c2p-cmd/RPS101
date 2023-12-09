//
//  GameModel.swift
//  RPS101
//
//  Created by Sharan Thakur on 06/12/23.
//

import SwiftUI

extension [RPSObject] {
    static var defaultValues: [RPSObject] {
        [
            RPSObject(name: "Cat", winningOutcomes: [
                ["chases","Bird"],["eats","Fish"],["eats","Spider"],["eats","Cockroach"],["has","Brain"],["amuses","Community"],["acts","Cross"],["steals","Money"],["entertains","Vampire"],["plays with","Sponge"],["disrupts","Church"],["licks","Butter"],["rips up","Book"],["rips up","Paper"],["creates dust","Cloud"],["rides on","Airplane"],["hunts by","Moon"],["in","Grass"],["on","Film"],["doesn't use","Toilet"],["breathes","Air"],["lives on","Planet"],["gut strings on","Guitar"],["drinks from","Bowl"],["knocks over","Cup"],["drinks","Beer"],["hates","Rain"],["drinks","Water"],["sleeps on","T.V."],["looks at","Rainbow"],["hides from","U.F.O."],["allergy kills","Alien"],["in","Prayer"],["lives on","Mountain"],["recognizes","Satan"],["outruns","Dragon"],["plays with","Diamond"],["colored","Platimum"],["colored","Gold"],["recognizes","Devil"],["atop","Fence"],["hair ruins","Video Game"],["doesn't need","Math"],["outruns","Robot"],["has","Heart"],["9 lives despite","Electricity"],["9 lives despite","Lightning"],["outruns","Medusa"],["has spiritual","Power"],["chases","Laser"]
            ])
        ]
    }
}

struct RPSObject: Identifiable {
    let name: String
    let winningOutcomes: [[String]]
    
    var id: String {
        name
    }
    
    func canWinAgainstWithReason(against object: RPSObject) -> [String]? {
        // Iterate through the winning outcomes
        for outcome in winningOutcomes {
            // Check if the outcome array has two elements and if the second element matches the opponent's name
            if outcome.count == 2 && outcome[1] == object.name {
                // Return the verb and opponent's name
                return outcome
            }
        }
        // Return nil if no winning outcome is found
        return nil
    }
}

extension RPSObject: Codable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name = "object"
        case winningOutcomes = "winning outcomes"
    }
}

enum GameError: Error, CustomStringConvertible {
    case message(String)
    case notFound
    
    var description: String {
        switch self {
        case .message(let string):
            return string
        case .notFound:
            return "Data not found"
        }
    }
}

struct RPSObjectKey: EnvironmentKey {
    static var defaultValue: [RPSObject] = .defaultValues
}

extension EnvironmentValues {
    var rpsObjects: [RPSObject] {
        get {
            return self[RPSObjectKey.self]
        }
        set {
            self[RPSObjectKey.self] = newValue
        }
    }
}
