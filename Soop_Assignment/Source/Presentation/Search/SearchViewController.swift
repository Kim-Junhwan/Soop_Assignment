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
    
    private let diContainer: SceneDIContainer
    private let searchController: UISearchController = .init()
    private let searchView: SearchView = .init(frame: .zero)
    private let emptyView: EmptyView = .init(frame: .zero)
    private let viewModel: SearchViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(viewModel: SearchViewModel, diContainer: SceneDIContainer) {
        self.viewModel = viewModel
        self.diContainer = diContainer
        super.init(nibName: nil, bundle: nil)
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
        let loadMore = searchView.searchResultCollectionView.rx.contentOffset
            .filter { contentOffset in
                let scrollView = self.searchView.searchResultCollectionView
                let currentOffset = contentOffset.y + scrollView.frame.height - scrollView.safeAreaInsets.bottom
                let contentSizeHeight = max(scrollView.contentSize.height, scrollView.frame.height)
                return currentOffset >= contentSizeHeight-80
            }
            .map{ _ in () }
            .asSignal(onErrorSignalWith: .empty())
        let input = SearchViewModel.Input(search: searchSignal, loadNextPage: loadMore)
        
        searchView.searchResultCollectionView.rx.itemSelected
            .subscribe(with: self, onNext: { owner, indexPath in
                let selectApp = owner.viewModel.searchResults[indexPath.row]
                owner.navigationController?.pushViewController(owner.diContainer.makeDetailViewController(selectedThumbnail: selectApp), animated: true)
            })
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        output.searchResult.asObservable()
            .do(onNext: { result in
                if result.isEmpty {
                    self.emptyView.searchWord = self.viewModel.currentSearchWord
                    self.view = self.emptyView
                } else {
                    self.view = self.searchView
                }
            })
            .bind(to: searchView.searchResultCollectionView.rx.items(cellIdentifier: SearchResultCollectionViewCell.identifier, cellType: SearchResultCollectionViewCell.self)) { index, element, cell in
            cell.configureCell(element)
        }
        .disposed(by: disposeBag)
        
        output.isLoading.emit(with: self) { owner, isLoading in
            if isLoading {
                LoadingView.show()
            } else {
                LoadingView.hide()
            }
        }
        .disposed(by: disposeBag)
        
        output.currentError
            .emit(with: self) { owner, error in
                owner.errorAlert(error: error)
            }
            .disposed(by: disposeBag)
    }
}
