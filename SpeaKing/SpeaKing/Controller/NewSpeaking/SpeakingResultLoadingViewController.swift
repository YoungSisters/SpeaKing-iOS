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
    
    let realm = try! Realm()
    
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
        
        getPronunciationScore(audioURL)
        saveAudioFileToS3(audioID, audioURL)
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
