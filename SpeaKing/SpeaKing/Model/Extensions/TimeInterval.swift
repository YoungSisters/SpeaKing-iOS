//
//  TimeInterval.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/18.
//

import Foundation

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        guard !(self.isNaN || self.isInfinite) else {
            return ""
        }
        
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
