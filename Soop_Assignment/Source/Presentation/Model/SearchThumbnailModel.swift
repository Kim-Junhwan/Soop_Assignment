//
//  SearchThumbnailModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/22.
//

struct SearchThumbnailModel {
    let appName: String
    let appIconImagePath: String
    let appId: Int
    let ratingScore: Double
    let userRatingCount: Int
    let appThumbnailImagePath: [String]
    let genre: String
    let developerName: String
    
    init(thumbnailEntity: SearchResultThumbnailEntity) {
        self.appName = thumbnailEntity.headerInfo.appName
        self.appIconImagePath = thumbnailEntity.headerInfo.appIconImagePath
        self.appId = thumbnailEntity.headerInfo.appId
        self.ratingScore = thumbnailEntity.ratingInfo.ratingScore
        self.userRatingCount = thumbnailEntity.ratingInfo.userRatingCount
        self.appThumbnailImagePath = thumbnailEntity.subInfo.appThumbnailImagePath
        self.genre = thumbnailEntity.subInfo.genre
        self.developerName = thumbnailEntity.subInfo.developerName
    }
}
