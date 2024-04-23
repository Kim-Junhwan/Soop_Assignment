//
//  HTTPMethod.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

enum HTTPMethod: String {
    case get

    var value: String {
        self.rawValue.uppercased()
    }
}
