//
//  NewSpeakingModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

struct NewSpeakingRequestModel: Codable {
    let categoryId: Int
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
    let userId: Int
    let speakingId: Int
    let categoryId: Int
    let categoryName: String
    let speakingUuid: String
    let title: String
    let saveDate: String
    let url: String
    let time: String
    let text: String
    let correctedText: String
    let pronunciation: String
    let speed: String
    let wordFrequency: [WordFrequencyModel]?
    let nlp: [NewSpeakingNLPModel]
}

struct WordFrequencyModel: Codable {
    let wordId: Int
    let word: String
    let count: Int
}

struct NewSpeakingNLPModel: Codable {
    let nlpId: Int
    let sentence: String
    let paraphrasing: String
    let formality: String
}
