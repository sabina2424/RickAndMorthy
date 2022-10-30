//
//  CharacterDetailsInputData.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

struct CharacterDetailsInputData {
    let avatarImage: String?
    let name: String?
    let gender: String?
    let status: Status?
    let species: String?
    let type: String?
    let location: String?
    
    func items() -> [String: String?] {
        return [.gender.capitalizingFirstLetter() : gender, .species.capitalizingFirstLetter() : species, .location.capitalizingFirstLetter() : location]
    }
    
    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "Unknown"
    }
}
