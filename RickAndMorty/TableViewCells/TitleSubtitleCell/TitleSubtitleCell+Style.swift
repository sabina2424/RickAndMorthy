//
//  TitleSubtitleCell+Style.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

extension TitleSubtitleTableViewCell {
    struct Style {
        static var defaultTitleColor: UIColor {
            return UIColor.lightGray
        }
        
        static var defaultTitleFont: UIFont {
            return UIFont.systemFont(ofSize: 16)
        }
        
        static var defaultSubtitleFont: UIFont {
            return UIFont.boldSystemFont(ofSize: 20)
        }
        
        static var defaultSubtitleColor: UIColor {
            return UIColor.green
        }
        
        public let defaultTitleColor: UIColor
        public let defaultTitleFont: UIFont
        public let defaultSubtitleColor: UIColor
        public let defaultSubtitleFont: UIFont
        
        init(titleColor: UIColor = defaultTitleColor,
             titleFont: UIFont = defaultTitleFont,
             subtitleColor: UIColor = defaultSubtitleColor,
             subtitleFont: UIFont = defaultSubtitleFont) {
            
            self.defaultTitleColor = titleColor
            self.defaultTitleFont = titleFont
            self.defaultSubtitleColor = subtitleColor
            self.defaultSubtitleFont = subtitleFont
        }
    }
}
