//
//  STTResultViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

import AVFoundation
import RealmSwift

class STTResultViewController: UIViewController {
    
    private let realm = try! Realm()
    
    private var player: AVAudioPlayer?
    private var timer: Timer!
    private let seekDuration = 2.0
    
    private var sttResultView = STTResultView(recordTitle: "", resultText: "")
    
    var contentView: STTResultView {
        return view as! STTResultView
    }
    
    override func loadView() {
        super.loadView()
        setupSTTResultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        // 플레이어 설정
        guard let audioId = NewSpeakingInfo.shared.audioId, let urlString = realm.object(ofType: Audio.self, forPrimaryKey: audioId)?.url else {
                print("Can't find audio url")
                return
            }

        guard let audioUrl = URL(string: urlString) else {
            assert(false, "Can't find audio url")
            return
        }
                
        player = try? AVAudioPlayer(contentsOf: audioUrl)
        player?.delegate = self
        
        // 오디오 전체 길이 설정
        guard let duration = player?.duration else {
            return
        }
        
        sttResultView.setOverallDuration(duration: duration)
    }
    
    func setupSTTResultView() {
        guard let title = NewSpeakingInfo.shared.title, let text = NewSpeakingInfo.shared.text else {
            assert(false)
            return
        }
        
        sttResultView = STTResultView(recordTitle: title, resultText: text)
        sttResultView.delegate = self

        view = sttResultView
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.title = "녹음 결과"
    }
}

extension STTResultViewController: STTResultViewDelegate {
    func moveToSpeakingAnalysis(text: String) {
        NewSpeakingInfo.shared.text = text
        let nextViewController = SpeakingResultLoadingViewController()
        nextViewController.delegate = self
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true)
    }
}

extension STTResultViewController: SpeakingResultLoadingViewControllerDelegate {
    func moveToResultViewController() {
        navigationController?.pushViewController(SpeakingResultViewController(), animated: true)
    }
}

// MARK: - Playing Audio

extension STTResultViewController: PlayerDelegate {
    func seekForward() {
        guard let player = player else {
            return
        }
        var newTime = player.currentTime + seekDuration
        if newTime > player.duration { newTime = player.duration }
        
        player.currentTime = newTime
        sttResultView.setCurrentTime(time: player.currentTime)
    }
    
    func seekBackward() {
        guard let player = player else {
            return
        }
        var newTime = player.currentTime - seekDuration
        if newTime < 0 { newTime = 0 }
        
        player.currentTime = newTime
        sttResultView.setCurrentTime(time: player.currentTime)
    }
    
    func playAudio() {
        player?.play()
        runTimer()
    }
    
    func pauseAudio() {
        player?.pause()
        invalidateTimer()
    }
    
    func movePlaytime(time: TimeInterval) {
        player?.currentTime = time
    }
    
    func runTimer() {
        self.timer = Timer(timeInterval: 0.01, target: self, selector: #selector(self.changeCurrentTimeWhilePlaying), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: .common)
    }
    
    @objc func changeCurrentTimeWhilePlaying() {
        guard let currentTime = self.player?.currentTime else {
            assert(false)
            return
        }
        
        self.sttResultView.setCurrentTime(time: currentTime)
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
}

extension STTResultViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        sttResultView.resetPlayer()
        self.invalidateTimer()
    }
}
