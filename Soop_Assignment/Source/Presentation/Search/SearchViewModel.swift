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
        let searchResult: Signal<String>
        let isLoading: Signal<Bool>
    }
    
    private let searchUsecase: SearchUsecase
    private let isLoading: PublishRelay<Bool> = .init()
    var disposeBag: DisposeBag = .init()
    
    init(searchUsecase: SearchUsecase) {
        self.searchUsecase = searchUsecase
    }
    
    func transform(input: Input) -> Output {
        let searchResult = input.search
            .do(onNext: { _ in
                self.isLoading.accept(true)
            })
            .flatMap { word in
                self.searchUsecase.excute(word: word, offset: 0).asSignal(onErrorJustReturn: [])
            }
            .do { _ in
                self.isLoading.accept(false)
            }
            
        
        return .init(searchResult: <#T##Signal<String>#>, isLoading: isLoading.asSignal())
    }
}
