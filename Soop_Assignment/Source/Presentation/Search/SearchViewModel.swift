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
        let tapCancelButton: ControlEvent<Void>
    }
    
    struct Output {
        let searchResult: Signal<[SearchThumbnailModel]>
        let isLoading: Signal<Bool>
        let currentError: Signal<Error>
    }
    
    private let searchUsecase: SearchUsecase
    private let isLoading: PublishRelay<Bool> = .init()
    private let searchResults: PublishRelay<[SearchThumbnailModel]> = .init()
    private let currentError: PublishRelay<Error> = .init()
    var disposeBag: DisposeBag = .init()
    
    init(searchUsecase: SearchUsecase) {
        self.searchUsecase = searchUsecase
    }
    
    func transform(input: Input) -> Output {
        let searchButtonClick = input.search
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
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
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(false)
            })
        let tapCancelButton = input.tapCancelButton
            .map { ()-> [SearchThumbnailModel] in
                return []
            }
        
        let searchResult = Signal<[SearchThumbnailModel]>.merge(searchButtonClick.asSignal(), tapCancelButton.asSignal(onErrorJustReturn: []))
        
        return .init(searchResult: searchResult, isLoading: isLoading.asSignal(), currentError: currentError.asSignal())
    }
}
