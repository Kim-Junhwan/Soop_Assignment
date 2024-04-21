//
//  DataRequest.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/21.
//

import Foundation

class DataRequest {
    let requestConvert: URLRequestConvertable
    
    init(requestConvert: URLRequestConvertable) {
        self.requestConvert = requestConvert
    }
}
