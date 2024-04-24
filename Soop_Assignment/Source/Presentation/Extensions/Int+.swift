//
//  Int+.swift
//  Soop_Assignment
//
//  Created by JunHwan Kim on 2024/04/24.
//

import Foundation

extension Int {
    func countCutting() -> String {
        if self<1000 {
            return "\(self)"
        } else if self<10000 {
            let cuttingNum = Double(self)/1000
            return String(format:"%.1f천", cuttingNum)
        } else {
            let cuttingNum = Double(self)/10000
            return String(format:"%.1f만", cuttingNum)
        }
    }
}
