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
    private let seekDuration = 10.0
    
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
//        guard let audioId = NewSpeakingInfo.shared.audioId, let urlString = realm.object(ofType: Audio.self, forPrimaryKey: audioId)?.url else {
//                print("Can't find audio url")
//                return
//            }
//
//        guard let audioUrl = URL(string: urlString) else {
//            assert(false, "Can't find audio url")
//            return
//        }
        
//        guard let urlString = realm.object(ofType: Audio.self, forPrimaryKey: "21BD4570-E1E0-4EF7-A290-FA649CE7F9D9")?.url else {
//            return
//        }
//        
        guard let audioUrl = URL(string: "file:///Users/seoyeong/Library/Developer/CoreSimulator/Devices/7F82EA3C-DDEE-4D46-8FAD-116C1878459E/data/Containers/Data/Application/C8DD50B3-8860-4E15-83A2-F994EFFFE534/Library/Caches/A66998CD-DA40-4A31-9912-15770855506C.wav") else {
            assert(false, "No audio file")
            return
        }
                
        player = try? AVAudioPlayer(contentsOf: audioUrl)
        
        // 오디오 전체 길이 설정
        guard let duration = player?.duration else {
            return
        }
        
        sttResultView.setOverallDuration(duration: duration)
//
//        // 현재 시간
//        let currentDuration = playerItem.currentTime()
//        let currentSeconds = CMTimeGetSeconds(currentDuration)
//
//        sttResultView.setCurrentTime(time: currentSeconds)
//
//        // 재생 관련 설정 (준비)
//        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { _ in
//            if self.player!.currentItem?.status == .readyToPlay {
//                let time = CMTimeGetSeconds(self.player!.currentTime())
//                self.sttResultView.setCurrentTime(time: time)
//            }
//
//            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
//            if playbackLikelyToKeepUp == false {
//                print("IsBuffering")
//            } else {
//                print("Buffering completed")
//            }
//        }
    }
    
    func setupSTTResultView() {
//        guard let title = NewSpeakingInfo.shared.title, let text = NewSpeakingInfo.shared.text else {
//            assert(false)
//            return
//        }
        
        let title = "test"
        let text = "hellloo"
        
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

extension STTResultViewController: PlayerDelegate {
    func seekForward() {
        guard let player = player else {
            return
        }
        
        player.currentTime = player.currentTime + seekDuration
        sttResultView.setCurrentTime(time: player.currentTime)
        
//        if let duration = player.currentItem?.duration {
//            let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
//            let newTime = playerCurrentTime + seekDuration
//
//            if newTime < CMTimeGetSeconds(duration) {
//                let selectedTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
//                player.seek(to: selectedTime)
//            }
//            player.pause()
//            player.play()
//        }
    }
    
    func seekBackward() {
        guard let player = player else {
            return
        }
        player.currentTime = player.currentTime - seekDuration
        sttResultView.setCurrentTime(time: player.currentTime)    }
    
    func playAudio() {
        player?.play()
    }
    
    func pauseAudio() {
        player?.pause()
    }
    
    func movePlaytime() {
        //
    }
    
    
}
