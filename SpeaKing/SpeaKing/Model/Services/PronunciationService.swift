//
//  PronunciationService.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/23.
//

import Foundation

import Alamofire

class PronunciationService {
    static func getPronunciationScore(audioURL: String, completion: @escaping (PronunciationModel) -> Void) {
        let url = Constants.PRO_URL
        
        guard let audio = getAudioEncodedString(audioURL) else {
            return
        }
        
        let header: HTTPHeaders = [
            "Authorization": Constants.API_KEY
        ]
        
        let parameters: Parameters = [
            "argument": [
                "language_code": "english",
                "audio": audio
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: PronunciationModel.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
    
    private static func getAudioEncodedString(_ audioURL: String) -> String? {
        guard let url = URL(string: audioURL) else {
            return nil
        }
        
        let audioData =  try? Data(contentsOf: url)
        let encodedString = audioData?.base64EncodedString()
        
        return encodedString
    }
}
