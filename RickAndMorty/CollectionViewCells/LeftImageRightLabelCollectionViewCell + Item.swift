//
//  LeftImageRightLabelCollectionViewCell + Item.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import Foundation
import UIKit

extension LeftImageRightLabelCollectionViewCell {
    struct Item: Equatable {
        let leftImage: String?
        let title: String?
        let subtitle: String?
        
        public init(leftImage: String?, title: String? = nil, subtitle: String? = nil) {
            self.leftImage = leftImage
            self.title = title
            self.subtitle = subtitle
        }
    }
}
