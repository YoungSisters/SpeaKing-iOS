//
//  LoginViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var contentView: LoginView {
        return view as! LoginView
    }
    
    override func loadView() {
        super.loadView()
        setupLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setupLoginView() {
        let loginView = LoginView()
        loginView.delegate = self
        
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate, NavigationDelegate {
    func pushSignUpViewController() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func pushNextViewController() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func navigateBack() {
    }
}
