//
//  MeModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/17.
//

import Foundation

struct MeModel: Codable {
    var result: MeResultModel
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct MeResultModel: Codable {
    var token: String
    var userId: Int
}
