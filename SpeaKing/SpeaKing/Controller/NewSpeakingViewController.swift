//
//  NewSpeakingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class NewSpeakingViewController: UIViewController {
    
    var contentView: NewSpeakingView {
        return view as! NewSpeakingView
    }
    
    override func loadView() {
        super.loadView()
        view = NewSpeakingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
