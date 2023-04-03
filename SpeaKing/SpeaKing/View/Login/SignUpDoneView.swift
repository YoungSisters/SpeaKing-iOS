//
//  SignUpDoneView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import UIKit

protocol SignUpDoneViewDelegate: AnyObject {
    func moveToHomeViewController()
}

class SignUpDoneView: UIView {
    
    private var doneView = SPLoadingView(title: "ㅇㅇㅇ님의\n회원가입이\n완료되었어요.", buttonTitle: "완료")
    
    weak var delegate: SignUpDoneViewDelegate?
    
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

extension SignUpDoneView {
    func style() {
        
    }
    
    func layout() {
        addSubview(doneView)
        
        doneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUserNickname(nickname: String) {
        doneView.title = "\(nickname)님의\n회원가입이 완료되었어요."
    }
    
    func configureButton() {
        doneView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func doneButtonTapped() {
        delegate?.moveToHomeViewController()
    }
}
