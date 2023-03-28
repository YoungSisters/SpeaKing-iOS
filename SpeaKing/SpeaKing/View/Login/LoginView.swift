//
//  LoginView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

class LoginView: UIView {
    
    var idTextField = OnboardingTextField(title: "아이디", placeholder: "이메일 주소를 입력해주세요.")
    var textField = SPTextField(placeholder: "이메일 주소")

    
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
    }
    
    func layout() {
        addSubview(idTextField)

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
//        
//        addSubview(textField)
//        
//        textField.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(32)
//            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
//        }
    }
}
