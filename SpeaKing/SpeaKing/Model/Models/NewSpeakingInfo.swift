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
    var categoryId: String?
    var categoryName: String?
    var formality: String?
    var audioId: String?
    var text: String?
    var pronunciation: String?
    var wpm: Double?
    
    private init() { }
    
    func resetNewSpeakingInfo() {
        title = nil
        categoryId = nil
        categoryName = nil
        formality = nil
        audioId = nil
        text = nil
        pronunciation = nil
        wpm = nil
    }
}
