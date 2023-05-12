//
//  RecordingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer?
    
    var contentView: RecordingView {
        return view as! RecordingView
    }
    
    override func loadView() {
        super.loadView()
        setupRecordingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureRecordingSession()
    }
    
    func setupRecordingView() {
        let recordingView = RecordingView()
        recordingView.delegate = self
        
        view = recordingView
    }
}

// MARK: - Audio Recording
extension RecordingViewController {
    func configureRecordingSession() {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                if allowed {
                    print("음성 녹음 허용")
                } else {
                    print("음성 녹음 비허용")
                }
            }
        } catch {
            print("음성 녹음 실패")
        }
    }
}

extension RecordingViewController: RecordingViewDelegate {
    func stopRecording() {
        print("stop")
    }
    
    func pauseRecording() {
        print("pause")
    }
    
    func playRecording() {
        print("play")
    }
    
    func finishRecording() {
        let loadingViewController = STTLoadingViewController()
        loadingViewController.modalPresentationStyle = .fullScreen
        
        self.present(loadingViewController, animated: true)
    }
}
