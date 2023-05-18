//
//  STTResultViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class STTResultViewController: UIViewController {
    
    var contentView: STTResultView {
        return view as! STTResultView
    }
    
    override func loadView() {
        super.loadView()
        setupSTTResultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSTTResultView() {
        guard let title = NewSpeakingInfo.shared.title, let text = NewSpeakingInfo.shared.text else {
            assert(false)
            return
        }
        
        let sttResultView = STTResultView(recordTitle: title, resultText: text)
        //        sttResultView.delegate = self

        view = sttResultView
    }

}

extension STTResultViewController {
    
}
