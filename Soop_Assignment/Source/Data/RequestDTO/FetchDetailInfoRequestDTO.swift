//
//  FetchDetailInfoRequestDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct FetchDetailInfoRequestDTO: Encodable {
    let id: Int
    let language: String = Rule.language
    let country: String = Rule.country
}
