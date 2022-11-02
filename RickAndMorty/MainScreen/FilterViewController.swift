//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by 003995_Mac on 01.11.22.
//

import UIKit

class FilterViewController: UIViewController {

    private let containerStackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var applyFilterButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        return button
    }()

    private lazy var clearFilterButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        return button
    }()
   
    struct Section {
        let title: String
        var items: [Filter]
        
        func getSelectedFilters() -> [String: [String]] {
            let selected = items.filter { $0.isSelected == true }.map(\.option)
            return [title : selected]
        }
    }
    
    struct Filter {
        var option: String
        var isSelected: Bool = false
    }
    
   
    var characterFilters = [Section(title: .species, items: [.init(option: "human"),
                                              .init(option: "alien")]),
             Section(title: .status, items: [.init(option: "alive"),
                                             .init(option: "dead"),
                                             .init(option: "unknown")]),
             Section(title: .gender, items: [.init(option: "male"),
                                             .init(option: "female"),
                                             .init(option: "unknown")])]
    private var selectedFilters: [String: [String]] = [:]
    
    var didApplyFilterTapped: (([String: [String]]) -> Void)?
    var didClearFilterTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    @objc private func applyFilter() {
        self.dismiss(animated: true)
        didApplyFilterTapped?(selectedFilters)
    }
    
    @objc private func clearFilter() {
        didClearFilterTapped?()
    }

    private func setupView() {
        [containerStackView, applyFilterButton, clearFilterButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     containerStackView.bottomAnchor.constraint(equalTo: applyFilterButton.topAnchor, constant: -12),
                                     
                                     applyFilterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                                     applyFilterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                                     applyFilterButton.heightAnchor.constraint(equalToConstant: 40),
                                     
                                     clearFilterButton.topAnchor.constraint(equalTo: applyFilterButton.bottomAnchor, constant: 16),
                                     clearFilterButton.leadingAnchor.constraint(equalTo: applyFilterButton.leadingAnchor),
                                     clearFilterButton.widthAnchor.constraint(equalTo: applyFilterButton.widthAnchor),
                                     clearFilterButton.heightAnchor.constraint(equalTo: applyFilterButton.heightAnchor),
                                     clearFilterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)])
        
        for (sIndex ,section) in characterFilters.enumerated() {
            let filterStackView = UIStackView()
            filterStackView.axis = .vertical
            filterStackView.distribution = .fillEqually
            filterStackView.backgroundColor = .gray
            filterStackView.backgroundColor = .white
            
            let sectionLabel = UILabel()
            sectionLabel.textAlignment = .left
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
            sectionLabel.textColor = UIColor.systemGray
            sectionLabel.text = section.title
            
            filterStackView.addArrangedSubview(sectionLabel)
            containerStackView.addArrangedSubview(filterStackView)
            
            for (index, item) in section.items.enumerated() {
                let filterView = UIView()
                filterView.backgroundColor = .white
                
                let filterLabel = UILabel()
                filterLabel.textAlignment = .left
                filterLabel.translatesAutoresizingMaskIntoConstraints = false
                filterLabel.text = item.option
                
                let checkboxButton = UIButton()
                checkboxButton.contentMode = .scaleToFill
                checkboxButton.translatesAutoresizingMaskIntoConstraints = false
                checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
                checkboxButton.addAction(.init(handler: { [weak self] _ in
                    self?.characterFilters[sIndex].items[index].isSelected = !(self?.characterFilters[sIndex].items[index].isSelected ?? false)
                    
                    self?.selectedFilters = self?.characterFilters[sIndex].getSelectedFilters() ?? [:]
                    
                    print("hereGet:", self?.characterFilters[sIndex].getSelectedFilters() ?? [:])
                    (self?.characterFilters[sIndex].items[index].isSelected ?? false) ? checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) : checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
                }), for: .touchUpInside)
                
                filterView.addSubview(filterLabel)
                filterView.addSubview(checkboxButton)
                filterStackView.addArrangedSubview(filterView)
                
                NSLayoutConstraint.activate([
                    filterLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor),
                    filterLabel.centerYAnchor.constraint(equalTo: filterView.centerYAnchor),
                    filterLabel.trailingAnchor.constraint(equalTo: checkboxButton.leadingAnchor, constant: -8),
                    
                    checkboxButton.trailingAnchor.constraint(equalTo: filterView.trailingAnchor),
                    checkboxButton.centerYAnchor.constraint(equalTo: filterView.centerYAnchor),
                    checkboxButton.heightAnchor.constraint(equalToConstant: 24),
                    checkboxButton.widthAnchor.constraint(equalToConstant: 24)
                ])
            }
        }
        
    }
    
    func getSelected(filters: [Section]) -> [String: [String]] {
        var selectedFilters: [String: [String]] = [:]
        filters.forEach { section in
        let selected = section.items.filter { $0.isSelected == true }.map(\.option)
        selectedFilters = [section.title : selected]
        }
        return selectedFilters
    }
}
