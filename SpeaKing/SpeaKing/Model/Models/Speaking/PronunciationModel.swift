//
//  PronunciationModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

struct PronunciationModel: Codable {
    var requestId: String?
    var result: Int?
    var returnType: String?
    var returnObject: PronuncationScore?
    var reason: String?

    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case result
        case returnType = "return_type"
        case returnObject = "return_object"
    }
}

struct PronuncationScore: Codable {
    var recognized: String
    var score: String
}
