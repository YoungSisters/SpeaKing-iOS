//
//  Date.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        return formatter.string(from: self)
    }
}
