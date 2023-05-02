//
//  CategoryListModel.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/02.
//

import Foundation

struct CategoryListModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [CategoryListResult]
}

struct CategoryListResult: Codable {
    let categoryId: Int
    let name: String
    let userId: Int
}
