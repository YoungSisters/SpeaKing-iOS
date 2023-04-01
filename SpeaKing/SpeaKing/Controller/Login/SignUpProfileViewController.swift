//
//  SignUpProfileViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit

class SignUpProfileViewController: UIViewController {

    var contentView: SignUpProfileView {
        return view as! SignUpProfileView
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSignUpProfileView() {
        let signUpProfileView = SignUpProfileView()
//        signUpView.delegate = self
        
        view = signUpProfileView
    }

}