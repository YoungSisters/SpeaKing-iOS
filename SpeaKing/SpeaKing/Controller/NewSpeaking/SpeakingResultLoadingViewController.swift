//
//  SpeakingResultLoadingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

import RealmSwift

protocol SpeakingResultLoadingViewControllerDelegate {
    func moveToResultViewController()
}

class SpeakingResultLoadingViewController: UIViewController {
    
    private let realm = try! Realm()
    
    private let dispatchGroup = DispatchGroup()
    
    var delegate: SpeakingResultLoadingViewControllerDelegate?
    
    var contentView: SpeakingResultLoadingView {
        return view as! SpeakingResultLoadingView
    }
    
    override func loadView() {
        super.loadView()
        setupSpeakingResultLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let audioID = NewSpeakingInfo.shared.audioId, let audioURL = realm.object(ofType: Audio.self, forPrimaryKey: audioID)?.url else {
            return
        }

        dispatchGroup.enter()
        getPronunciationScore(audioURL)

        dispatchGroup.enter()
        saveAudioFileToS3(audioID, audioURL)

        dispatchGroup.notify(queue: .main) {
            self.requestNewSpeakingResult()
        }
    }
    
    func setupSpeakingResultLoadingView() {
        let speakingResultLoadingView = SpeakingResultLoadingView()
        speakingResultLoadingView.delegate = self
        
        view = speakingResultLoadingView
    }
}

// MARK: - Networking

extension SpeakingResultLoadingViewController {
    func getPronunciationScore(_ audioURL: String) {
        PronunciationService.getPronunciationScore(audioURL: audioURL) { result in
            NewSpeakingInfo.shared.pronunciation = result.returnObject?.score
            self.dispatchGroup.leave()
        }
    }
    
    func saveAudioFileToS3(_ audioID: String, _ audioURL: String) {
        guard let url = URL(string: audioURL), let data = try? Data(contentsOf: url) else {
            assert(false)
            return
        }
        
        FileService().uploadAudioToS3(audioID, data) {
            guard let userID = KeychainManager.get()?.userId else {
                assert(false)
                return
            }
            
            let url = "\(Constants.BUCKET)/\(userID)/\(audioID).wav"
            
            NewSpeakingInfo.shared.audioURL = url
            
            print(url)
            self.dispatchGroup.leave()
        }
    }
    
    func requestNewSpeakingResult() {
        guard let categoryId = NewSpeakingInfo.shared.categoryId, let categoryName = NewSpeakingInfo.shared.categoryName else {
            assert(false)
            return
        }
        
        guard let speakingUuid = NewSpeakingInfo.shared.audioId, let speakingTitle = NewSpeakingInfo.shared.title, let text = NewSpeakingInfo.shared.text, let wpm = NewSpeakingInfo.shared.wpm, let time = NewSpeakingInfo.shared.time else {
            assert(false)
            return
        }
        
        guard let pronunciation = NewSpeakingInfo.shared.pronunciation, let url = NewSpeakingInfo.shared.audioURL, let selectedformality = NewSpeakingInfo.shared.formality else {
            assert(false)
            return
        }
        
        let speed = String(format: "%.2f", wpm)
        let saveDate = Date().formatted()
        
        let speakingInfo = NewSpeakingRequestModel(categoryId: categoryId, categoryName: categoryName, speakingUuid: speakingUuid, title: speakingTitle, saveDate: saveDate, text: text, url: url, time: time, pronunciation: String(format: "%.2f", pronunciation), speed: speed, selectedformality: selectedformality)
        
        NewSpeakingService.postNewSpeaking(parameters: speakingInfo) { result in
            // TODO:
            // 로딩 완료 화면으로 전환
            // 다음 뷰컨으로 결과 전달
            print(result)
        }
    }
}

// MARK: - SpeakingResultLoadingViewDelegate

extension SpeakingResultLoadingViewController: SpeakingResultLoadingViewDelegate {
    func pushNextViewController() {
        self.dismiss(animated: true) {
            self.delegate?.moveToResultViewController()
        }
    }
}
