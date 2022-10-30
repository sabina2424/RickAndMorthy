//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

class CharacterDetailsViewModel {
    let inputData: CharacterDetailsInputData
    
    init(inputData: CharacterDetailsInputData) {
        self.inputData = inputData
    }
    
    func setupStatus() -> String {
        switch inputData.status {
        case .alive:
            return CharacterDetailsInputData.Status.alive.rawValue
        case .dead:
            return CharacterDetailsInputData.Status.dead.rawValue
        default:
            return CharacterDetailsInputData.Status.unknown.rawValue
        }
    }
}
