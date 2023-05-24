//
//  SpeakingResultViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

import AVFoundation
import RealmSwift

class SpeakingResultViewController: UIViewController {
    
    private let realm = try! Realm()
    
    private var player: AVAudioPlayer?
    private var timer: Timer!
    private let seekDuration = 2.0

    private var speakingResultView = SpeakingResultView()
    
    private var result: NewSpeakingResultModel

    var contentView: SpeakingResultView {
        return view as! SpeakingResultView
    }
    
    required init(result: NewSpeakingResultModel) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupSpeakingResultView()
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
        
        speakingResultView.setOverallDuration(duration: duration)
    }
    
    func setupSpeakingResultView() {
        speakingResultView.delegate = self
        speakingResultView.setSpeakingResult(result: result)
        
        view = speakingResultView
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.title = "분석 결과"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
    }
    
    @objc func rightBarButtonItemTapped() {
        navigationController?.popToRootViewController(animated: true)
        NewSpeakingInfo.shared.resetNewSpeakingInfo()
    }
}

// MARK: - Playing Audio

extension SpeakingResultViewController: PlayerDelegate {
    func seekForward() {
        guard let player = player else {
            return
        }
        var newTime = player.currentTime + seekDuration
        if newTime > player.duration { newTime = player.duration }
        
        player.currentTime = newTime
        speakingResultView.setCurrentTime(time: player.currentTime)
    }
    
    func seekBackward() {
        guard let player = player else {
            return
        }
        var newTime = player.currentTime - seekDuration
        if newTime < 0 { newTime = 0 }
        
        player.currentTime = newTime
        speakingResultView.setCurrentTime(time: player.currentTime)
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
        
        self.speakingResultView.setCurrentTime(time: currentTime)
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
}

extension SpeakingResultViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        speakingResultView.resetPlayer()
        self.invalidateTimer()
    }
}
