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
        
        // Do any additional setup after loading the view.
    }
    
    func setupSpeakingResultView() {
        let speakingResultView = SpeakingResultView()
//        speakingResultView.delegate = self
        
        view = speakingResultView
    }

}
