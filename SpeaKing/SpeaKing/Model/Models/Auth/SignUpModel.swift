//
//  SignUpModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import Foundation

// MARK: - Request
struct SignUpModel: Codable {
    var email: String
    var password: String
    var nickname: String
    var intro: String?
    var url: String?
}

// MARK: - Response
struct SignUpResponseModel: Codable {
    let result: SignUpResult
    let isSuccess: Bool
    let code: Int
    let message: String
}

struct SignUpResult: Codable {
    let token: String
    let userId: Int
}
