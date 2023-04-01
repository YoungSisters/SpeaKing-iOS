//
//  SignUpView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit

class SignUpView: UIView {
    
    var titleView = SPTitleView(title: "회원 정보를 입력해주세요.", subtitle: nil)
    
    var idTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "아이디", placeholder: "이메일 주소를 입력해주세요.")
        
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    var pwTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "비밀번호", placeholder: "8자리 이상으로 입력해주세요.")
        
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    var pwCheckTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "비밀번호 확인", placeholder: "비밀번호를 한 번 더 입력해주세요.")
        
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    var nextButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("다음", for: .normal)
        
        return button
    }()
    
    var delegate: NavigationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension SignUpView {
    func style() {
        self.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        let stackView = UIStackView(arrangedSubviews: [idTextField, pwTextField, pwCheckTextField])
        stackView.axis = .vertical
        stackView.spacing = 32
        
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        delegate?.pushNextViewController()
    }
}
