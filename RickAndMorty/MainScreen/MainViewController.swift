//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 30.10.22.
//

import UIKit

class MainViewController: UIViewController {
    
   private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return activityIndicator
    }()
    
    private lazy var searchController: UISearchController = {
        let searchView = UISearchController()
        searchView.searchResultsUpdater = self
        searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.placeholder = Constants.searchText
        return searchView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: UIScreen.main.bounds.width - 24, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LeftImageRightLabelCollectionViewCell.self, forCellWithReuseIdentifier: "\(LeftImageRightLabelCollectionViewCell.self)")
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var collectionViewFlowLayout : CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
        return layout
    }()
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.fetchData()
        setupViewModel()
        setupView()
    }
    
    private func setupViewModel() {
        viewModel.changeHandler = { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
        }
    }
    
    private func render(state: MainViewState) {
        switch state {
        case .loaded:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .error(let error):
            print("error", error)
//            self.showAlert(title: error?.errorDescription,
//                           message: error?.failureReason,
//                           buttonTitle: Constants.cancel,
//                           style: .cancel) { _ in
//                self.dismiss(animated: true, completion: nil)
    //        }
        case .isFetching(let isFetching):
            DispatchQueue.main.async {
                isFetching ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setupView() {
        self.title = "Rick and Morthy forever!"
        view.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = collectionViewFlowLayout
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LeftImageRightLabelCollectionViewCell.self)", for: indexPath) as? LeftImageRightLabelCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.characters[indexPath.row]
        cell.configure(item: .init(leftImage: item.image ?? "", title: item.name, subtitle: item.gender))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.currentPage += 1
            self.viewModel.fetchData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.characters[indexPath.row]
        navigationController?.pushViewController(CharacterDetailsViewController(viewModel: CharacterDetailsViewModel(inputData: .init(avatarImage: data.image, name: data.name, gender: data.gender, status: .init(rawValue: data.status ?? "Unknown"), species: data.species, type: data.type, location: data.location?.name))), animated: true)
    }
}

// MARK: - SearchController Update delegate
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

