//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .green
        return label
    }()
    
    lazy var characterAvatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.downloadImage(urlString: viewModel.inputData.avatarImage ?? "")
        return image
    }()
    
    lazy var customAvatarView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 25.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        containerView.layer.shadowRadius = 10.0
        containerView.layer.shadowOpacity = 0.9
        containerView.layer.masksToBounds = true
        containerView.clipsToBounds = false
        containerView.addSubview(characterAvatar)
        containerView.addSubview(statusLabel)
        return containerView
    }()
    
    lazy var backgoundBlureImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.downloadImage(urlString: viewModel.inputData.avatarImage ?? "")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = image.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.addSubview(blurEffectView)
        return image
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: "\(TitleSubtitleTableViewCell.self)")
        return tableView
    }()
    
    let viewModel: CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        statusLabel.text = viewModel.setupStatus()
    }
    
    private func setupView() {
        [backgoundBlureImage, customAvatarView, tableView].forEach { view.addSubview($0) }
        backgoundBlureImage.frame = self.view.bounds
        NSLayoutConstraint.activate([
            customAvatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customAvatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            customAvatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            customAvatarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            characterAvatar.topAnchor.constraint(equalTo: customAvatarView.topAnchor),
            characterAvatar.leadingAnchor.constraint(equalTo: customAvatarView.leadingAnchor),
            characterAvatar.trailingAnchor.constraint(equalTo: customAvatarView.trailingAnchor),
            characterAvatar.bottomAnchor.constraint(equalTo: customAvatarView.bottomAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: customAvatarView.topAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: customAvatarView.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
        
            tableView.topAnchor.constraint(equalTo: customAvatarView.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension CharacterDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.inputData.items().count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleSubtitleTableViewCell.self)", for: indexPath) as? TitleSubtitleTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        let key = Array(viewModel.inputData.items().keys.sorted())[indexPath.row]
        let value = Array(viewModel.inputData.items().values)[indexPath.row]
        cell.configure(item: .init(title: key, subtitle: value), style: .init())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
