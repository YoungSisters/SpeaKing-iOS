//
//  LoginTextField.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/24.
//

import UIKit

class OnboardingTextField: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.body)
        
        return label
    }()
    
    var textField: SPTextField!
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    required init(title: String, placeholder: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        textField = SPTextField(placeholder: placeholder)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingTextField {
    func style() {
        
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])

        stackView.axis = .vertical
        stackView.spacing = 16
//        stackView.alignment = .leading

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension OnboardingTextField {
    func setTextFieldType(type: UIKeyboardType) {
        textField.keyboardType = type
    }
}
