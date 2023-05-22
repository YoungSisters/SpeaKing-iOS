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
        
        // Do any additional setup after loading the view.
        getPronunciationScore()
    }
    
    func setupSpeakingResultLoadingView() {
        let speakingResultLoadingView = SpeakingResultLoadingView()
        speakingResultLoadingView.delegate = self
        
        view = speakingResultLoadingView
    }
}

// MARK: - Networking

extension SpeakingResultLoadingViewController {
    func getPronunciationScore() {
        guard let audioID = NewSpeakingInfo.shared.audioId, let audioURL = realm.object(ofType: Audio.self, forPrimaryKey: audioID)?.url else {
            return
        }
        
        PronunciationService.getPronunciationScore(audioURL: audioURL) { result in
            NewSpeakingInfo.shared.pronunciation = result.returnObject?.score
            print(result.returnObject?.score)
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
