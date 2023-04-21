//
//  SignUpDoneViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import UIKit

class SignUpDoneViewController: UIViewController {
    
    private var nickname: String!
    
    private let signUpDoneView = SignUpDoneView()
    
    var contentView: SignUpDoneView {
        return view as! SignUpDoneView
    }
    
    init(nickname: String) {
        super.init(nibName: nil, bundle: nil)
        self.nickname = nickname
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupSignUpDoneView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserNickname()
    }
    
    func setupSignUpDoneView() {
        signUpDoneView.delegate = self
        view = signUpDoneView
    }
    
    func setUserNickname() {
        signUpDoneView.setUserNickname(nickname: self.nickname)
    }
}

extension SignUpDoneViewController: SignUpDoneViewDelegate {
    func moveToHomeViewController() {
        let navigationController = UINavigationController(rootViewController: HomeViewController(profileService: ProfileService()))
        self.changeRootViewController(navigationController)
    }
}
