//
//  TitleSubtitleCell+Item.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation

extension TitleSubtitleTableViewCell {
     struct Item: Equatable {
        let title: String
        let subtitle: String?
         
      public init(title: String, subtitle: String? = nil) {
            self.title = title
            self.subtitle = subtitle
        }
    }
}
