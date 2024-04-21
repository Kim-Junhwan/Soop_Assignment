//
//  URLRequestConvertable.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import Foundation

protocol URLRequestConvertable {
    func makeURLRequest() throws -> URLRequest
}
