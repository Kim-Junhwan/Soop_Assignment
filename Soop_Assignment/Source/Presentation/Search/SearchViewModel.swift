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
    }
    
    struct Output {
        let searchResult: Signal<[SearchThumbnailModel]>
        let isLoading: Signal<Bool>
    }
    
    private let searchUsecase: SearchUsecase
    private let isLoading: PublishRelay<Bool> = .init()
    private let searchResults: PublishRelay<[SearchThumbnailModel]> = .init()
    var disposeBag: DisposeBag = .init()
    
    init(searchUsecase: SearchUsecase) {
        self.searchUsecase = searchUsecase
    }
    
    func transform(input: Input) -> Output {
        input.search
            .do(onNext: { [weak self] _ in
                self?.isLoading.accept(true)
            })
            .flatMap { word in
                self.searchUsecase.excute(word: word, offset: 0).asSignal(onErrorJustReturn: [])
            }
            .map { result in
                result.map { SearchThumbnailModel(thumbnailEntity: $0) }
            }
            .emit(with: self) { owner, result in
                owner.isLoading.accept(false)
                owner.searchResults.accept(result)
            }
            .disposed(by: disposeBag)
            
        
        return .init(searchResult: searchResults.asSignal(), isLoading: isLoading.asSignal())
    }
}
