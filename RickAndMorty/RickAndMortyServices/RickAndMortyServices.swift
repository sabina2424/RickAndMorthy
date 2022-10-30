//
//  RickAndMortyServices.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

protocol CharactersNetworkServiceProtocol {
    typealias CompletionHandler = (Result<ResponseModel, NetworkError>) -> Void
    
    func getCharacters(page: Int, filters: FilterCharactersRequestModel?, completion: @escaping CompletionHandler)
}

class CharactersNetworkService: CharactersNetworkServiceProtocol {
    let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func getCharacters(page: Int, filters: FilterCharactersRequestModel? = nil, completion: @escaping CompletionHandler) {
        service.request(endpoint: RickAndMortyEndPoints.getCharacters(page: page, filters: filters),
                        completion: completion)
    }
}
