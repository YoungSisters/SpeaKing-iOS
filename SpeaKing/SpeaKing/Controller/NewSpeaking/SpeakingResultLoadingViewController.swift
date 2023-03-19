//
//  SpeakingResultLoadingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class SpeakingResultLoadingViewController: UIViewController {
    var contentView: SpeakingResultLoadingView {
        return view as! SpeakingResultLoadingView
    }
    
    override func loadView() {
        super.loadView()
        setupSpeakingResultLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSpeakingResultLoadingView() {
        let speakingResultLoadingView = SpeakingResultLoadingView()
//        speakingResultLoadingView.delegate = self
        
        view = speakingResultLoadingView
    }
}
