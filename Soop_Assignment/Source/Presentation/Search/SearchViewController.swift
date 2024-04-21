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
    private let searchView: SearchView = .init(frame: .zero)
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        setNavigationBar()
        view.backgroundColor = .systemBackground
    }
    
    private func setNavigationBar() {
        navigationItem.title = Word.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}
