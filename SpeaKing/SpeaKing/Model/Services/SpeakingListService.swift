//
//  SpeakingListService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/24.
//

import Foundation

import Alamofire

class SpeakingListService {
    static func getSpeakingList(_ categoryID: Int?, _ title: String?, completion: @escaping ([SpeakingListResultModel]) -> Void) {
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        var url = Constants.BASE_URL + Constants.SPEAKING
        
        if let categoryID = categoryID {
            url += "&categoryId=\(categoryID)"
        }
        
        if let title = title {
            url += "&title=\(title)"
        }
        
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(encodedURL, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: SpeakingListModel.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.result)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
    
    static func getSpeakingResult(_ speakingID: Int, completion: @escaping (NewSpeakingResultModel) -> Void) {
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        let url = Constants.BASE_URL + Constants.SPEAKING + "/\(speakingID)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: NewSpeakingResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.result)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}
