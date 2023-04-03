//
//  SignUpViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit

class SignUpViewController: UIViewController {

    var contentView: SignUpView {
        return view as! SignUpView
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSignUpView() {
        let signUpView = SignUpView()
        signUpView.delegate = self
        
        view = signUpView
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func pushSignUpProfileViewController(email: String, password: String) {
        let userInfo = SignUpModel(email: email, password: password, nickname: "", intro: "", url: "")
        navigationController?.pushViewController(SignUpProfileViewController(signUpService: AuthService(), userInfo: userInfo), animated: true)
    }
}
