//
//  NewSpeakingService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

import Alamofire

class NewSpeakingService {
    static func postNewSpeaking(parameters: NewSpeakingRequestModel,
                            completion: @escaping (NewSpeakingResultModel) -> Void) {
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        let url = Constants.BASE_URL + Constants.SPEAKING
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: NewSpeakingResponseModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response.result)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}
