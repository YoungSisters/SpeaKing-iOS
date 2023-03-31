//
//  LoginView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

protocol LoginViewDelegate {
    func pushSignUpViewController()
}

class LoginView: UIView {
    
    var idTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "아이디", placeholder: "이메일 주소를 입력해주세요.")
        
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    var pwTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "비밀번호", placeholder: "비밀번호를 입력해주세요.")
        
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        
        let title = NSMutableAttributedString()
            .regular(string: "계정이 없으신가요? ", fontSize: FontSize.subhead)
            .bold(string: "회원가입", fontSize: FontSize.subhead)
        
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(Color.Main, for: .normal)
        
        return button
    }()
    
    var loginButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("로그인", for: .normal)
        
        return button
    }()
    
    weak var delegate: (LoginViewDelegate & NavigationDelegate)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

}

extension LoginView {
    func style() {
        self.backgroundColor = Color.Background
        self.dismissKeyboardWhenTappedAround()
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [idTextField, pwTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 32
        
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureButtons() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        delegate?.pushSignUpViewController()
    }
}
