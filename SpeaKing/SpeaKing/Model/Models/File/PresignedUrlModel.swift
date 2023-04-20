//
//  PresignedUrlModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/18.
//

import Foundation

struct PresignedUrlModel: Codable {
    let result: String
    let isSuccess: Bool
    let code: Int
    let message: String
}
