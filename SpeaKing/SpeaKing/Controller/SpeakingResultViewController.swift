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
    
    private var isNew = false
    private var result: NewSpeakingResultModel

    var contentView: SpeakingResultView {
        return view as! SpeakingResultView
    }
    
    required init(isNew: Bool, result: NewSpeakingResultModel) {
        self.isNew = isNew
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
        var urlString = ""
        if let urlPath = realm.object(ofType: Audio.self, forPrimaryKey: result.speakingUuid)?.url {
            urlString = urlPath
            setupAudioPlayer(urlString: urlString)
        } else {
            DownloadAndSaveFile.downloadAndSaveAudioFile(result.speakingUuid, result.url) { savedPath in
                let audioData = Audio(id: self.result.speakingUuid, url: savedPath)
                
                DispatchQueue.main.async {
                    try! self.realm.write {
                        self.realm.add(audioData)
                    }
                }
                
                urlString = savedPath
                self.setupAudioPlayer(urlString: urlString)
            }
        }
    }
    
    func setupSpeakingResultView() {
        speakingResultView.delegate = self
        speakingResultView.setSpeakingResult(result: result)
        
        view = speakingResultView
    }
    
    func configureNavigationBar() {
        navigationItem.title = "분석 결과"
        if isNew {
            navigationItem.hidesBackButton = true
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        } else {
            navigationItem.hidesBackButton = false
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    @objc func rightBarButtonItemTapped() {
        navigationController?.popToRootViewController(animated: true)
        NewSpeakingInfo.shared.resetNewSpeakingInfo()
    }
}

// MARK: - AVAudioPlayer

extension SpeakingResultViewController {
    func setupAudioPlayer(urlString: String) {
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
