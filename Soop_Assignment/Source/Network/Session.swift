//
//  CustomSession.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import Foundation

class Session {
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request(converter: URLRequestConvertable) -> DataRequest {
        let request = DataRequest(requestConvert: converter)
        
        return request
    }
}
