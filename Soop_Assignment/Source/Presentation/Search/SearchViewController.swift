//
//  SearchViewController.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum Word {
        static let navigationTitle = "검색"
    }
    
    private let searchController: UISearchController = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }

    private func configureView() {
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = Word.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    private func setConstraints() {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}
