//
//  ITunesRouter.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

enum ITunesRouter: URLRequestConvertable {
    
    case search(SearchRequestDTO)
    
    func makeURLRequest() throws -> URLRequest {
        <#code#>
    }
}
