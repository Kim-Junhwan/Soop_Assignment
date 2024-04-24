//
//  DetailResponseDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct DetailResponseDTO: Decodable {
    let results: [DetailResponseItemDTO]
    
    func toDomain() throws -> DetailInfoEntity {
        guard let detailInfo = results.first else { throw ITunesAPIError.strangeResult }
        let headerInfo = AppHeaderEntity(appName: detailInfo.trackName, appIconImagePath: detailInfo.artworkUrl512, appId: detailInfo.trackId)
        let ratingEntity = AppRatingEntity(ratingScore: detailInfo.averageUserRating, userRatingCount: detailInfo.userRatingCount)
        let subInfo = AppSubInfoEntity(appThumbnailImagePath: detailInfo.screenshotUrls, genre: detailInfo.primaryGenreName, developerName: detailInfo.artistName)
        guard let releaseDate = detailInfo.currentVersionReleaseDate.toDate() else { fatalError("cannot convert string to date") }
        let releaseEntity = AppReleaseEntity(releaseDate: releaseDate, releaseNote: detailInfo.releaseNotes, version: detailInfo.version)
        let descriptionEntity = AppDescriptionEntity(description: detailInfo.description)
        return .init(headerInfo: headerInfo, ratingInfo: ratingEntity, subInfo: subInfo, releaseInfo: releaseEntity, descriptionInfo: descriptionEntity, age: detailInfo.trackContentRating)
    }
}

struct DetailResponseItemDTO: Decodable {
    let screenshotUrls: [String]
    let trackName: String // 이름
    let primaryGenreName: String
    let trackContentRating: String // 연령제한
    let description: String // 설명
    let price: Double // 가격
    let sellerName: String // 개발자 이름
    let formattedPrice: String // 가격(무료/유료)
    let userRatingCount: Int // 평가자 수
    let averageUserRating: Double // 평균 평점
    let artworkUrl512: String // 아이콘 이미지
    let languageCodesISO2A: [String] // 언어 지원
    let trackId: Int
    let version: String
    let releaseNotes: String
    let artistName: String
    let currentVersionReleaseDate: String
}
