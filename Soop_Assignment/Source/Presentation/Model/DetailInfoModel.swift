//
//  DetailInfoModel.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct DetailInfoModel {
    let appName: String
    let appIconImagePath: String
    let appId: Int
    let ratingScore: Double
    let userRatingCount: Int
    let appThumbnailImagePath: [String]
    let genre: String
    let developerName: String
    let description: String
    let version: String
    let age: String
    let languageList: [String]
    
    init(detailEntity: DetailInfoEntity) {
        self.appName = detailEntity.headerInfo.appName
        self.appIconImagePath = detailEntity.headerInfo.appIconImagePath
        self.appId = detailEntity.headerInfo.appId
        self.ratingScore = detailEntity.ratingInfo.ratingScore
        self.userRatingCount = detailEntity.ratingInfo.userRatingCount
        self.appThumbnailImagePath = detailEntity.subInfo.appThumbnailImagePath
        self.genre = detailEntity.subInfo.genre
        self.developerName = detailEntity.subInfo.developerName
        self.description = detailEntity.descriptionInfo.description
        self.version = detailEntity.releaseInfo.version
        self.age = detailEntity.age
        self.languageList = detailEntity.languageList
    }
}
