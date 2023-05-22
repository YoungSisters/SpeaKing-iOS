//
//  NewSpeakingModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

struct NewSpeakingRequestModel: Codable {
    let categoryId: String
    let categoryName: String
    let speakingUuid: String
    let title: String
    let saveDate: String
    let text: String
    let url: String
    let time: String
    let pronunciation: String
    let speed: String
}

struct NewSpeakingResponseModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: NewSpeakingResultModel
}

struct NewSpeakingResultModel: Codable {
    let categoryId: String
    let categoryName: String
    let speakingUuid: String
    let title: String
    let saveDate: String
    let text: String
    let url: String
    let time: String
    let pronunciation: String
    let speed: String
    let nlp: [NewSpeakingNLPModel]
}

struct NewSpeakingNLPModel: Codable {
    let nlpId: Int
    let sentence: String
    let paraphrasing: String
    let formality: String
}
