//
//  CategoryService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/02.
//

import Foundation
import Alamofire

protocol CategoryServiceProtocol {
    func getCategoryList(_ completion: @escaping (CategoryListModel) -> Void)
}

class CategoryService: CategoryServiceProtocol {
    func getCategoryList(_ completion: @escaping (CategoryListModel) -> Void) {
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        let url = Constants.BASE_URL + Constants.CATEGORY
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: CategoryListModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        
    }
}
