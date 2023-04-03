//
//  AuthService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import Foundation
import Alamofire

protocol AuthServiceProtocol {
    func signUp(_ userInfo: SignUpModel, _ completion: @escaping (SignUpResponseModel) -> Void)
}

class AuthService: AuthServiceProtocol {
    func signUp(_ userInfo: SignUpModel, _ completion: @escaping (SignUpResponseModel) -> Void) {
        let url = Constants.baseUrl + Constants.auth + Constants.signUp
        
        AF.request(url, method: .post, parameters: userInfo, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SignUpResponseModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(debugPrint(error))
                }
            }
    }
}
