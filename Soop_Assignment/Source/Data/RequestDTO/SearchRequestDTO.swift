//
//  SearchRequestDTO.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

struct SearchRequestDTO: Encodable {
    let term: String
    let offset: Int
}
