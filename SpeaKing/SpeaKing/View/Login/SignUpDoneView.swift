//
//  SignUpDoneView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import UIKit

class SignUpDoneView: UIView {
    var doneView = SPLoadingView(title: "ㅇㅇㅇ님의\n회원가입이\n완료되었어요.", buttonTitle: "완료")
    
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

extension SignUpDoneView {
    func style() {
        
    }
    
    func layout() {
        addSubview(doneView)
        
        doneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
