//
//  SignUpDoneViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import UIKit

class SignUpDoneViewController: UIViewController {
    
    var contentView: SignUpDoneView {
        return view as! SignUpDoneView
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpDoneView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSignUpDoneView() {
        let signUpDoneView = SignUpDoneView()
//        signUpDoneView.delegate = self
        
        view = signUpDoneView
    }
}
