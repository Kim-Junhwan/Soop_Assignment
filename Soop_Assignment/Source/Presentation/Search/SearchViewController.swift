//
//  SearchViewController.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    
    enum Word {
        static let navigationTitle = "검색"
    }
    
    private let searchController: UISearchController = .init()
    private let searchView: SearchView = .init(frame: .zero)
    private let viewModel: SearchViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    private func configureView() {
        setNavigationBar()
        view.backgroundColor = .systemBackground
    }
    
    private func setNavigationBar() {
        navigationItem.title = Word.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    private func bind() {
        let searchSignal = searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
            .asSignal(onErrorJustReturn: "")
        
        let input = SearchViewModel.Input(search: searchSignal)
        let output = viewModel.transform(input: input)
        output.searchResult
            .emit(with: self) { owner, result in
                print(result)
            }
            .disposed(by: disposeBag)
    }
}
