//
//  SearchViewModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/22.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelBase {
    
    struct Input {
        let search: Signal<String>
        let loadNextPage: Signal<Void>
    }
    
    struct Output {
        let searchResult: Signal<[SearchThumbnailModel]>
        let isLoading: Signal<Bool>
        let currentError: Signal<Error>
        let searchResultIsEmpty: Signal<String>
    }
    
    private let searchUsecase: SearchUsecase
    private let isLoading: PublishRelay<Bool> = .init()
    var searchResults: [SearchThumbnailModel] = []
    private let currentError: PublishRelay<Error> = .init()
    private let isLoadingNextPage: BehaviorRelay<Bool> = .init(value: false)
    private let hasNextPage: BehaviorRelay<Bool> = .init(value: false)
    private var searchResultIsEmpty: PublishRelay<String> = .init()
    var currentSearchWord: String = ""
    var disposeBag: DisposeBag = .init()
    
    init(searchUsecase: SearchUsecase) {
        self.searchUsecase = searchUsecase
    }
    
    func transform(input: Input) -> Output {
        let resetEvent = input.search
            .map { _ in [SearchThumbnailModel]() }
            .asSignal()
        let searchButtonClick = input.search
            .do(onNext: { [weak self] word in
                self?.isLoading.accept(true)
                self?.currentSearchWord = word
            })
            .flatMap { word in
                self.searchUsecase.excute(word: word, offset: 0)
                    .do(onError: { [weak self] error in
                        self?.currentError.accept(error)
                    })
                    .asSignal(onErrorJustReturn: [])
            }
            .map { result in
                result.map { SearchThumbnailModel(thumbnailEntity: $0) }
            }
            .do(onNext: { [weak self] result in
                guard let self else { return }
                self.hasNextPage.accept(result.count >= Rule.fetchCount)
                self.isLoading.accept(false)
                if result.isEmpty {
                    self.searchResultIsEmpty.accept(self.currentSearchWord)
                }
                self.searchResults = result
            })
        
        let loadMore = input.loadNextPage
            .withLatestFrom(Observable.combineLatest(isLoadingNextPage, hasNextPage).asSignal(onErrorJustReturn: (false, false)))
            .filter { isLoading, hasNextPage in
                return !isLoading && hasNextPage
            }
            .do(onNext: { _ in
                self.isLoading.accept(true)
                self.isLoadingNextPage.accept(true)
            })
            .flatMap { _ in
                return self.searchUsecase.excute(word: self.currentSearchWord, offset: self.searchResults.count).asSignal(onErrorJustReturn: [])
            }
            .do { result in
                self.hasNextPage.accept(result.count >= Rule.fetchCount)
            }
            .map { result in
                let loadResult = result.map { SearchThumbnailModel(thumbnailEntity: $0) }
                return self.searchResults+loadResult
            }
            .do { loadResult in
                self.isLoading.accept(false)
                self.isLoadingNextPage.accept(false)
                self.searchResults = loadResult
            }
        
        let searchResult = Signal<[SearchThumbnailModel]>.merge(searchButtonClick.asSignal(), loadMore, resetEvent)
        
        return .init(searchResult: searchResult, isLoading: isLoading.asSignal(), currentError: currentError.asSignal(), searchResultIsEmpty: searchResultIsEmpty.asSignal())
    }
}
