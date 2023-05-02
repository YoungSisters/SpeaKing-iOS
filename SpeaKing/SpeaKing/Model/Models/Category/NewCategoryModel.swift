//
//  NewCategoryModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/02.
//

import Foundation

struct NewCategoryModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CategoryResult
}
