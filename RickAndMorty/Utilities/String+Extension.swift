//
//  String+Extension.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

extension String {
    static let page = "page"
    static let name = "name"
    static let species = "species"
    static let status = "status"
    static let gender = "gender"
    static let type = "type"
    static let location = "location"
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

