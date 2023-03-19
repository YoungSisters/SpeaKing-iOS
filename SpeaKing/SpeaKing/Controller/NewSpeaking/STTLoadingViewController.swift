//
//  STTLoadingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class STTLoadingViewController: UIViewController {
    var contentView: STTLoadingView {
        return view as! STTLoadingView
    }
    
    override func loadView() {
        super.loadView()
        setupSTTLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSTTLoadingView() {
        let sttLoadingView = STTLoadingView()
//        sttLoadingView.delegate = self
        
        view = sttLoadingView
    }
}
