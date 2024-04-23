//
//  SearchResponseDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct SearchResponseDTO: Decodable {
    let results: [SearchResponseItem]
    
    func toDomain() -> [SearchResultThumbnailEntity] {
        return results.map { info in
            let headerInfo = AppHeaderEntity(appName: info.trackName, appIconImagePath: info.artworkUrl512, appId: info.trackId)
            let ratingEntity = AppRatingEntity(ratingScore: info.averageUserRating, userRatingCount: info.userRatingCount)
            let subInfo = AppSubInfoEntity(appThumbnailImagePath: info.screenshotUrls, genre: info.primaryGenreName, developerName: info.artistName)
            return .init(headerInfo: headerInfo, ratingInfo: ratingEntity, subInfo: subInfo)
        }
    }
}

struct SearchResponseItem: Decodable {
    let screenshotUrls: [String]
    let trackName: String
    let primaryGenreName: String
    let trackContentRating: String
    let description: String
    let sellerName: String
    let userRatingCount: Int
    let averageUserRating: Double
    let artworkUrl512: String
    let languageCodesISO2A: [String]
    let trackId: Int
    let version: String
    let releaseNotes: String
    let artistName: String
}
