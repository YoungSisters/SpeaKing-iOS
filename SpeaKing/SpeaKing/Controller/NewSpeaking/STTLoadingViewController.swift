//
//  STTLoadingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

import RealmSwift
import Speech

protocol STTLoadingViewControllerDelegate {
    func moveToNextViewController()
}

class STTLoadingViewController: UIViewController {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    private let realm = try! Realm()
    
    var delegate: STTLoadingViewControllerDelegate?
    
    var contentView: STTLoadingView {
        return view as! STTLoadingView
    }
    
    override func loadView() {
        super.loadView()
        setupSTTLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .notDetermined: print("Not determined")
            case .restricted: print("Restricted")
            case .denied: print("Denied")
            case .authorized: print("We can recognize speech now.")
            @unknown default: print("Unknown case")
            }
        }
        
        transcribeAudio()
    }
    
    func setupSTTLoadingView() {
        let sttLoadingView = STTLoadingView()
//        sttLoadingView.delegate = self
        
        view = sttLoadingView
    }
}

// MARK: - Speech Recognition

extension STTLoadingViewController {
    func transcribeAudio() {
        guard let audioId = NewSpeakingInfo.shared.audioId, let urlString = realm.object(ofType: Audio.self, forPrimaryKey: audioId)?.url else {
                print("Can't find audio url")
                return
            }
        
        guard let audioUrl = URL(string: urlString) else {
            assert(false, "Can't find audio url")
            return
        }

            if speechRecognizer!.isAvailable {
                let request = SFSpeechURLRecognitionRequest(url: audioUrl)
                request.addsPunctuation = true
                speechRecognizer?.supportsOnDeviceRecognition = true
                speechRecognizer?.recognitionTask(
                    with: request,
                    resultHandler: { (result, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            self.dismiss(animated: true)
                        } else if let result = result {
                            print(result.bestTranscription.formattedString)
                            if result.isFinal {
                                NewSpeakingInfo.shared.text = result.bestTranscription.formattedString
                                NewSpeakingInfo.shared.wpm = result.speechRecognitionMetadata?.speakingRate
                                
                                self.dismiss(animated: true) {
                                    self.delegate?.moveToNextViewController()
                                }
                            }
                        }
                    })
            }
        }
}
