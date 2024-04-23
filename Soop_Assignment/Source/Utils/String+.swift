//
//  String+.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
