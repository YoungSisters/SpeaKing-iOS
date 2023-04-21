//
//  ProfileModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/21.
//

import Foundation

struct ProfileModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ProfileResponseModel
}

struct ProfileResponseModel: Codable {
    var userId: Int
    var email: String
    var nickname: String
    var intro: String?
    var url: String?
}
