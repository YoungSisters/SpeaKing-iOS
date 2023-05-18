//
//  SpeakingResultViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

class SpeakingResultViewController: UIViewController {

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
    }
    
    func setupSpeakingResultView() {
        let speakingResultView = SpeakingResultView()
//        speakingResultView.delegate = self
        
        view = speakingResultView
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.title = "분석 결과"
    }

}
