//
//  TitleSubtitleTableViewCell.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

class TitleSubtitleTableViewCell: UITableViewCell {
    
   private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(item: Item, style: Style) {
        setupCell()
        titleLabel.text = item.title
        titleLabel.font = style.defaultTitleFont
        titleLabel.textColor = style.defaultTitleColor
        if let subtitle = item.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = style.defaultSubtitleColor
            subtitleLabel.font = style.defaultSubtitleFont
        }
    }
    
    private func setupCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 6),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 6)
        ])
    }

}
