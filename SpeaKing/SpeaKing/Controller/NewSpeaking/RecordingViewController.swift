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
    
    private var isFirstTimeRecording = true

    private var audioId: String?
    let realm = try! Realm()
    
    // Timer
    private var seconds = 0
    private var timer = Timer()
    
    let recordingView = RecordingView()
    
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
        runTimer()
    }
    
    func setupRecordingView() {
        recordingView.delegate = self
        
        view = recordingView
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSpeakingTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateSpeakingTime() {
        seconds += 1
        let nowMinute = String(format: "%02d", seconds / 60)
        let nowSecond = String(format: "%02d", seconds % 60)
        
        recordingView.setSpeakingTimeLabel(time: "\(nowMinute):\(nowSecond)")
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
        
        NewSpeakingInfo.shared.audioId = audioId

        let audioData = Audio(id: audioId, url: audioRecorder.url.absoluteString)
        
        try! realm.write {
            realm.add(audioData)
        }
    }
}

// MARK: - Recording View
extension RecordingViewController: RecordingViewDelegate {
    func stopRecording() {
        finishRecording(isDone: false)
        
        timer.invalidate()
        seconds = 0
        recordingView.setSpeakingTimeLabel(time: "00:00")
        
        isFirstTimeRecording = true
    }
    
    func pauseRecording() {
        audioRecorder.pause()
        timer.invalidate()
    }
    
    func playRecording() {
        if isFirstTimeRecording {
            startRecording()
        } else {
            audioRecorder.record()
        }
        isFirstTimeRecording = false
        print(isFirstTimeRecording)
        runTimer()
    }
    
    func finishRecordingAndMoveToNext() {
        finishRecording(isDone: true)
        
        timer.invalidate()
        
        let loadingViewController = STTLoadingViewController()
        loadingViewController.delegate = self
        loadingViewController.modalPresentationStyle = .fullScreen
        
        self.present(loadingViewController, animated: true)
    }
}

extension RecordingViewController: STTLoadingViewControllerDelegate {
    func moveToNextViewController() {
        self.navigationController?.pushViewController(STTResultViewController(), animated: true)
    }
}
