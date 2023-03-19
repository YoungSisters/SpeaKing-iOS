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
        let sttResultView = STTResultView()
//        sttResultView.delegate = self
        
        view = sttResultView
    }

}

extension STTResultViewController {
    
}
