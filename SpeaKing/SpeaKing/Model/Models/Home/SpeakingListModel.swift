//
//  SpeakingListModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/24.
//

import Foundation

struct SpeakingListModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [SpeakingListResultModel]
}

struct SpeakingListResultModel: Codable {
    let categoryId: Int
    let categoryName: String
    let speakingId: Int
    let title: String
    let saveDate: String
    let recordTime: String
    let speakingUuid: String
}
