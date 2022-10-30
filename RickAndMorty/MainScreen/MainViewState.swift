//
//  MainViewState.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation
enum MainViewState {
    case loaded
    case isFetching(Bool)
    case error(NetworkError?)
}
