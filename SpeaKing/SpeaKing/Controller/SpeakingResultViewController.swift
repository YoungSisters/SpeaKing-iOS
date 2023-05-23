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
    
//    private var result: NewSpeakingResultModel

    var contentView: SpeakingResultView {
        return view as! SpeakingResultView
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
        let result = NewSpeakingResultModel(userId: 1, speakingId: 1, categoryId: 1, categoryName: "hi", speakingUuid: "str", title: "title", saveDate: "2023-05-24", url: "www", time: "02:13", text: "She lived in a small house at Asheville. The uh the small neighborhood I remember she lived in was very uh quiet mostly older people and uh we used to go around the small neighborhood and visit lot of her old friends.", correctedText: "She lived in a small house at Asheville. The [uh] small neighborhood I remember she lived in was very [uh] quiet, mostly older people, and [uh] we used to go around the small neighborhood and visit a lot of her old friends.", pronunciation: "3.7", speed: "127", wordFrequency: [WordFrequencyModel(wordId: 86, word: "small", count: 3)], nlp: [NewSpeakingNLPModel(nlpId: 8, sentence: "She lived in a small house at Asheville.", paraphrasing: "She lived in a small house. ", formality: "Formal")], selectedformality: "Informal")
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
