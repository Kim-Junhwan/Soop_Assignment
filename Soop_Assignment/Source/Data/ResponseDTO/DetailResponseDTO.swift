//
//  DetailResponseDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct DetailResponseDTO: Decodable {
    let screenshotUrls: [String]
    let artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let advisories: [String]
    let kind: String
    let averageUserRating: Double
    let formattedPrice, minimumOSVersion, trackCensoredName: String
    let fileSizeBytes, contentAdvisoryRating: String
    let trackContentRating: String
    let currentVersionReleaseDate: String
    let releaseNotes, resultDescription: String
    let primaryGenreName: String
    let trackID: Int
    let trackName, sellerName, currency: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let artistName: String
    let genres: [String]
    let price: Int
    let version: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case isGameCenterEnabled, advisories, supportedDevices, features, kind, averageUserRating, formattedPrice
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion
        case trackViewURL = "trackViewUrl"
        case trackContentRating, currentVersionReleaseDate, releaseNotes
        case resultDescription = "description"
        case genreIDS = "genreIds"
        case releaseDate, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case bundleID = "bundleId"
        case trackID = "trackId"
        case trackName, sellerName, currency, isVppDeviceBasedLicensingEnabled
        case artistID = "artistId"
        case artistName, genres, price, version, wrapperType, userRatingCount
    }
}
