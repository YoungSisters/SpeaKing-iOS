//
//  ProfileService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/21.
//

import Foundation
import Alamofire

protocol ProfileServiceProtocol {
    func getUserProfile(_ completion: @escaping () -> Void)
}

class ProfileService: ProfileServiceProtocol {
    func getUserProfile(_ completion: @escaping () -> Void) {
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        let url = Constants.BASE_URL + Constants.PROFILE
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let response):
                    UserDefaultsManager.setData(value: response.result.email, key: .email)
                    UserDefaultsManager.setData(value: response.result.nickname, key: .nickname)
                    UserDefaultsManager.setData(value: response.result.intro, key: .intro)
                    completion()
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}
