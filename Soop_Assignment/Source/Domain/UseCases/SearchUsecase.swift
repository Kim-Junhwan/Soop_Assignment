//
//  SearchUsecase.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import RxSwift

protocol SearchUsecase {
    func excute(word: String, offset: Int) -> Single<[SearchResultThumbnailEntity]>
}

final class DefaultSearchUsecase {
    private let itunesRepository: ITunesRepository
    
    init(itunesRepository: ITunesRepository) {
        self.itunesRepository = itunesRepository
    }
}

extension DefaultSearchUsecase: SearchUsecase {
    
    func excute(word: String, offset: Int) -> Single<[SearchResultThumbnailEntity]> {
        let query = SearchQuery(searchWord: word, offset: offset)
        return Single.create { single in
            let task = self.itunesRepository.fetchSearchResultList(query: query) { result in
                switch result {
                case .success(let searchResult):
                    single(.success(searchResult))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
