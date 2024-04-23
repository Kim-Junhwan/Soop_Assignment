//
//  DomainDIContainer.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

final class DomainDIContainer {
    private let networkDIContainer = NetworkDIContainer()
    
    lazy var searchUsecase: SearchUsecase = {
        let searchUsecase = DefaultSearchUsecase(itunesRepository: networkDIContainer.itunesRepository)
        return searchUsecase
    }()
    
    lazy var fetchDetailInfoUsecase: FetchDetailInfoUsecase = {
        let detailUsecase = DefaultFetchDetailInfoUsecase(itunesRepository: networkDIContainer.itunesRepository)
        return detailUsecase
    }()
}
