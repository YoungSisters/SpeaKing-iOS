//
//  AuthService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import Foundation
import Alamofire

protocol AuthServiceProtocol {
    func authenticateToken(_ token: String, _ completion: @escaping (MeModel) -> Void)
    func signUp(_ userInfo: SignUpModel, _ completion: @escaping (SignUpResponseModel) -> Void)
    func login(_ userInfo: LoginModel, _ completion: @escaping (LoginResponseModel) -> Void)
}

class AuthService: AuthServiceProtocol {
    func authenticateToken(_ token: String, _ completion: @escaping (MeModel) -> Void) {
        let url = Constants.BASE_URL + Constants.AUTH + Constants.ME
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseDecodable(of: MeModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(debugPrint(error))
                }
            }
    }
    
    func login(_ userInfo: LoginModel, _ completion: @escaping (LoginResponseModel) -> Void) {
        let url = Constants.BASE_URL + Constants.AUTH + Constants.LOGIN
        
        AF.request(url, method: .post, parameters: userInfo, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponseModel.self) { response in
                switch response.result {
                case .success(let response):
                    do {
                        try KeychainManager.save(
                            userId: "\(response.result.userId)",
                            token: response.result.token.data(using: .utf8) ?? Data())
                    }
                    catch {
                        print(error)
                    }
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
                    do {
                        try KeychainManager.save(
                            userId: "\(response.result.userId)",
                            token: response.result.token.data(using: .utf8) ?? Data())
                    }
                    catch {
                        print(error)
                    }
                    completion(response)
                case .failure(let error):
                    print(debugPrint(error))
                }
            }
    }
}
