//
//  FileService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/18.
//

import Foundation
import Alamofire

protocol FileServiceProtocol {
    func getPresignedUrl(_ fileName: String, _ completion: @escaping (String) -> Void)
    func uploadImageToS3(_ imageName: String, imageData: Data)
    func uploadAudioToS3(_ audioName: String, _ audioData: Data, _ completion: @escaping () -> Void)
}

class FileService: FileServiceProtocol {
    func uploadAudioToS3(_ audioName: String, _ audioData: Data, _ completion: @escaping () -> Void) {
        self.getPresignedUrl("\(audioName).wav") { url in
            let headers: HTTPHeaders = [
                "Content-Type": "audio/wav"
            ]
            
            AF.upload(audioData, to: url, method: .put, headers: headers)
                .validate()
                .response { _ in
                    completion()
                }
        }
    }
    
    func uploadImageToS3(_ imageName: String, imageData: Data) {
        self.getPresignedUrl("\(imageName).jpeg") { url in
            let headers: HTTPHeaders = [
                "Content-Type": "image/jpeg"
            ]
            AF.upload(imageData, to: url, method: .put, headers: headers)
                .validate()
                .responseString { response in
                    debugPrint(response)
                }
        }
    }
    
    func getPresignedUrl(_ fileName: String, _ completion: @escaping (String) -> Void) {
        let url = Constants.BASE_URL + Constants.PRESIGNED
        
        guard let token = KeychainManager.get()?.token else {
            assert(false, "Can't find token")
        }
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let body: Parameters = [
            "filename": fileName
        ]
        
        AF.request(url, method: .get, parameters: body, encoding: URLEncoding.queryString, headers: header)
            .validate()
            .responseDecodable(of: PresignedUrlModel.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess {
                        print(response.result)
                        completion(response.result)
                    } else {
                        print(false)
                    }
                case .failure(let error):
                    print(debugPrint(error))
                }
            }
    }
}
