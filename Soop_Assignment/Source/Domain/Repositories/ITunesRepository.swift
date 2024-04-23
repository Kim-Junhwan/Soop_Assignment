//
//  ITunesRepository.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import RxSwift

protocol ITunesRepository {
    func fetchSearchResultList(query: SearchQuery, completion: @escaping (Result<[SearchResultThumbnailEntity], Error>) -> Void) -> Cancellable?
    func fetchDetailInfo(query: FetchDetailInfoQuery, completion: @escaping (Result<DetailInfoEntity, Error>) -> Void) -> Cancellable?
}
