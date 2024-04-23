//
//  FetchDetailInfoUsecase.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import RxSwift

protocol FetchDetailInfoUsecase {
    func excute(appId: Int) -> Single<DetailInfoEntity>
}

final class DefaultFetchDetailInfoUsecase {
    private let itunesRepository: ITunesRepository
    
    init(itunesRepository: ITunesRepository) {
        self.itunesRepository = itunesRepository
    }
}

extension DefaultFetchDetailInfoUsecase: FetchDetailInfoUsecase {
    func excute(appId: Int) -> Single<DetailInfoEntity> {
        let query = FetchDetailInfoQuery(appId: appId)
        return Single.create { single in
            let task = self.itunesRepository.fetchDetailInfo(query: query) { result in
                switch result {
                case .success(let detailInfo):
                    single(.success(detailInfo))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
