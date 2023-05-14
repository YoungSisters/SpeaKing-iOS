//
//  RecordingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit
import AVFoundation
import RealmSwift

class RecordingViewController: UIViewController {
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer?
    
    private var audioId: String?
    let realm = try! Realm()
    
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
        startRecording()
    }
    
    func setupRecordingView() {
        let recordingView = RecordingView()
        recordingView.delegate = self
        
        view = recordingView
    }
}

// MARK: - Audio Recording
extension RecordingViewController: AVAudioRecorderDelegate {
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        audioId = UUID().uuidString
        let audioUrl = getDocumentsDirectory().appendingPathComponent("\(audioId!).wav")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioUrl, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            print("녹음 시작")
        } catch {
            finishRecording(isDone: false)
        }
    }
    
    func finishRecording(isDone: Bool) {
        audioRecorder.stop()
        
        if isDone {
            saveRecordingData()
            print("finishRecording - success")
        } else {
            audioRecorder.deleteRecording()
            print("finishRecording - fail")
        }
        audioRecorder = nil
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(isDone: false)
        }
    }
    
    func saveRecordingData() {
        guard let audioId = audioId else {
            assert(false)
            return
        }
        
        let audioData = Audio(id: audioId, url: audioRecorder.url.absoluteString)
        
        try! realm.write {
            realm.add(audioData)
        }
    }
}

extension RecordingViewController: RecordingViewDelegate {
    func stopRecording() {
        finishRecording(isDone: false)
    }
    
    func pauseRecording() {
        audioRecorder.pause()
    }
    
    func playRecording() {
        audioRecorder.record()
    }
    
    func finishRecordingAndMoveToNext() {
        finishRecording(isDone: true)
        
        let loadingViewController = STTLoadingViewController()
        loadingViewController.modalPresentationStyle = .fullScreen
        
        self.present(loadingViewController, animated: true)
    }
}
