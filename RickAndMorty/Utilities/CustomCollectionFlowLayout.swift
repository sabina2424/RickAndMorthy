//
//  CustomCollectionFlowLayout.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

enum CollectionDisplay {
    case list
    case grid(columns: Int)
}

extension CollectionDisplay: Equatable {
    
    public static func == (lhs: CollectionDisplay, rhs: CollectionDisplay) -> Bool {
        
        switch (lhs, rhs) {
        case (.grid(let lColumn), .grid(let rColumn)):
            return lColumn == rColumn
            
        default:
            return false
        }
    }
}

class CustomCollectionViewFlowLayout : UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .list {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    var containerWidth: CGFloat = 0.0 {
        didSet {
            if containerWidth != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay, containerWidth: CGFloat) {
        self.init()
        
        self.display = display
        self.containerWidth = containerWidth
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configLayout()
    }
    
    func configLayout() {
        switch display {
        case .grid(let column):
            self.scrollDirection = .vertical
            let spacing = CGFloat(column + 1) * minimumLineSpacing
            let optimisedWidth = (containerWidth - spacing) / CGFloat(column)
            self.itemSize = CGSize(width: optimisedWidth, height: optimisedWidth * 0.7)
        case .list:
            self.scrollDirection = .vertical
            self.itemSize = CGSize(width: containerWidth - minimumLineSpacing, height: 200)
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
