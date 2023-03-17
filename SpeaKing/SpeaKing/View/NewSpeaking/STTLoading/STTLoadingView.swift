//
//  STTLoadingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class STTLoadingView: UIView {
    
    var loadingView = SPLoadingView()
    
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

extension STTLoadingView {
    func style() {
        loadingView.titleLabel.text = "SpeaKING이\n사용자 님의 말하기를\n텍스트로 변환하고 있어요."
    }
    
    func layout() {
        addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
