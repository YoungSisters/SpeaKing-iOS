//
//  SignUpProfileView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import UIKit

class SignUpProfileView: UIView {
    
    var titleView = SPTitleView(title: "프로필을 입력해주세요.", subtitle: nil)
    
    var nicknameTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "닉네임", placeholder: "최대 00자까지 입력 가능해요.")
                
        return textField
    }()
    
    var introTextField: OnboardingTextField = {
        let textField = OnboardingTextField(title: "한 줄 다짐", placeholder: "한 줄 다짐이나 소개를 작성해보세요.")
                
        return textField
    }()
    
    var doneButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("가입하기", for: .normal)
        
        return button
    }()
    
    var profileEditView = SPProfileEditView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
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

extension SignUpProfileView {
    func style() {
        self.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        

        addSubview(profileEditView)

        profileEditView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews: [nicknameTextField, introTextField])
        stackView.axis = .vertical
        stackView.spacing = 32
        
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileEditView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureButton() {
        doneButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        delegate?.pushNextViewController()
    }
}
