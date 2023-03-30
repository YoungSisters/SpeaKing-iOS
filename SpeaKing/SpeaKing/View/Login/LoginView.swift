//
//  LoginView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
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
        addSubview(idTextField)

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
