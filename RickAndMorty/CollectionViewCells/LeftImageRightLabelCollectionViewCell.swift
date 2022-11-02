//
//  LeftImageRightLabelCollectionViewCell.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

class LeftImageRightLabelCollectionViewCell: UICollectionViewCell {
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // MARK: - Public API
    func configure(item: Item) {
        configureAppearance()
        setupCell()
        leftImageView.downloadImage(urlString: item.leftImage ?? "")
        if let _ = item.title, let _ = item.subtitle {
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
        }
    }
    
    // MARK: - Private API
    private func setupCell() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func configureAppearance() {
        contentView.layer.borderColor = UIColor.green.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 6
    }
}

