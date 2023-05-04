//
//  NewSpeakingInfo.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/05.
//

import Foundation

class NewSpeakingInfo {
    static let shared = NewSpeakingInfo()
    
    var title: String?
    var category: String?
    var situation: String?
    
    private init() { }
}
