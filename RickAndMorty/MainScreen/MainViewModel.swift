//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

class MainViewModel {
    
    private let service: CharactersNetworkServiceProtocol
    var characters: [Character] = []
    var currentPage: Int = 1
    
    init(service: CharactersNetworkServiceProtocol = CharactersNetworkService()) {
        self.service = service
    }
    
    var changeHandler: ((MainViewState) -> Void)?
    
     func fetchData() {
        changeHandler?(.isFetching(true))
        service.getCharacters(page: currentPage, filters: nil) { [weak self] result in
            guard let self = self else { return }
            self.changeHandler?(.isFetching(false))
            switch result {
            case .success(let response):
                self.characters.append(contentsOf: response.results ?? [])
                self.changeHandler?(.loaded)
            case .failure(let error):
                self.changeHandler?(.error(error))
            }
        }
    }
}
