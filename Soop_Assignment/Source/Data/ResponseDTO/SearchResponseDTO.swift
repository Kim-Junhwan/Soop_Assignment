//
//  SearchResponseDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct SearchResponseDTO: Decodable {
    let results: [SearchResponseItem]
}

struct SearchResponseItem: Decodable {
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
}
