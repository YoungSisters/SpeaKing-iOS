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
    func login(_ userInfo: LoginModel, _ completion: @escaping (LoginResponseModel) -> Void)
}

class AuthService: AuthServiceProtocol {
    func login(_ userInfo: LoginModel, _ completion: @escaping (LoginResponseModel) -> Void) {
        let url = Constants.BASE_URL + Constants.AUTH + Constants.LOGIN
        
        AF.request(url, method: .post, parameters: userInfo, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponseModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(debugPrint(error))
                }
            }
    }
    
    func signUp(_ userInfo: SignUpModel, _ completion: @escaping (SignUpResponseModel) -> Void) {
        let url = Constants.BASE_URL + Constants.AUTH + Constants.SIGN_UP
        
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
