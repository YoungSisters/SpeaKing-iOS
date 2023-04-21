//
//  LoginViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginService: AuthServiceProtocol!
    
    var contentView: LoginView {
        return view as! LoginView
    }
    
    init(loginService: AuthServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.loginService = loginService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension LoginViewController: LoginViewDelegate {
    func callLoginApi(userInfo: LoginModel) {
        loginService.login(userInfo) { response in
            if response.isSuccess {
                let navigationController = UINavigationController(rootViewController: HomeViewController(profileService: ProfileService()))
                self.changeRootViewController(navigationController)
            }
        }
    }
    
    func pushSignUpViewController() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
