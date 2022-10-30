//
//  RickAndMortyEndPoints.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

enum RickAndMortyEndPoints: EndPoint {
    case getCharacters(page: Int, filters: FilterCharactersRequestModel?)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "rickandmortyapi.com"
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/api/character"
        }
    }
    
    var parameters: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        switch self {
        case let .getCharacters(page, filters):
            queryItems.append(URLQueryItem(name: .page, value: String(page)))
            guard let filters = filters else { return queryItems }
            queryItems.append(contentsOf: queryParameters(filters: filters))
            return queryItems
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [HTTPHeaders : String] {
        let headers: [HTTPHeaders : String] = [.contentType : "application/json"]
        return headers
    }
    
    var body: Data? { return nil }
}

extension RickAndMortyEndPoints {
    func queryParameters(filters: FilterCharactersRequestModel) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        if let name = filters.name {
            queryItems.append(URLQueryItem(name: .name, value: name))
        }
        
        if let species = filters.species {
            queryItems.append(URLQueryItem(name: .species, value: species))
        }
        
        if let status = filters.status {
            queryItems.append(URLQueryItem(name: .status, value: status))
        }
        return queryItems
    }
}
