//
//  LoginModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import Foundation

struct LoginModel: Codable {
    let email: String
    let password: String
}

struct LoginResponseModel: Codable {
    let result: LoginResult
    let isSuccess: Bool
    let code: Int
    let message: String
}

struct LoginResult: Codable {
    let token: String
    let userId: Int
}
