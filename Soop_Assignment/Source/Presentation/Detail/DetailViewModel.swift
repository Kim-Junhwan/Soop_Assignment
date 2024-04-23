//
//  DetailViewModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/23.
//

import Foundation

final class DetailViewModel {
    
    private let appThumbnailModel: SearchThumbnailModel
    private let fetchDetailInfoUsecase: FetchDetailInfoUsecase
    
    init(appThumbnailModel: SearchThumbnailModel, fetchDetailInfoUsecase: FetchDetailInfoUsecase) {
        self.appThumbnailModel = appThumbnailModel
        self.fetchDetailInfoUsecase = fetchDetailInfoUsecase
    }
    
    
}
