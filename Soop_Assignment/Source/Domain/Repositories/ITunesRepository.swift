//
//  ITunesRepository.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import RxSwift

protocol ITunesRepository {
    func fetchSearchResultList(query: SearchQuery) -> Single<[SearchResultThumbnailEntity]>
    func fetchDetailInfo(query: FetchDetailInfoQuery) -> Single<DetailInfoEntity>
}
