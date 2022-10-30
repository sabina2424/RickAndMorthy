//
//  ResponseModel.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

// MARK: - Welcome
struct ResponseModel: Codable {
    let info: PaginationModel?
    let results: [Character]?
}

// MARK: - Info
struct PaginationModel: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: CharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct CharacterLocation: Codable {
    let name: String?
    let url: String?
}
