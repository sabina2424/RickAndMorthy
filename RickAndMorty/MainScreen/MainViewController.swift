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
       activityIndicator.color = .systemGray
       activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var searchController: UISearchController = {
        let searchView = UISearchController()
        searchView.searchResultsUpdater = self
        searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.searchTextField.leftView?.tintColor = UIColor.green
        searchView.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.searchText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])
        searchView.searchBar.delegate = self
        return searchView
    }()
    
    lazy var backgoundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "blure")
        imageView.frame = view.bounds
        return imageView
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
        viewModel.fetchData()
        setupViewModel()
        setupView()
    }
    
    @objc private func filterTapped() {
        let filterViewController = FilterViewController()
        filterViewController.didApplyFilterTapped = { [weak self] filters in
            
            print("here isFilter: ", filters)
        }
        let nav = UINavigationController(rootViewController: filterViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]

        }
        present(nav, animated: true, completion: nil)
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.filter, style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.searchController = searchController
        [backgoundImage, collectionView, activityIndicator].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        cell.configure(item: .init(leftImage: item.image ?? "", title: item.name, subtitle: item.species))
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
        let charactersViewController = CharacterDetailsViewController(viewModel: CharacterDetailsViewModel(inputData: .init(avatarImage: data.image, name: data.name, gender: data.gender, status: .init(rawValue: data.status ?? "Unknown"), species: data.species, type: data.type, location: data.location?.name)))
        
        navigationController?.pushViewController(charactersViewController, animated: true)
    }
}

// MARK: - SearchController Update delegate
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }
        print(searchText)
    }
}


