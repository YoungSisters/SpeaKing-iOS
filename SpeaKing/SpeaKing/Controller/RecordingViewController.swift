//
//  RecordingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class RecordingViewController: UIViewController {
    
    var contentView: RecordingView {
        return view as! RecordingView
    }
    
    override func loadView() {
        super.loadView()
        setupRecordingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupRecordingView() {
        let recordingView = RecordingView()
        recordingView.delegate = self
        
        view = recordingView
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
        print("finish")
    }
}
