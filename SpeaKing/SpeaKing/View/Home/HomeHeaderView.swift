//
//  HomeHeaderView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/10.
//

import UIKit

class HomeHeaderView: UIView {
    
    var newSpeakingButton = NewSpeakingButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension HomeHeaderView {
    func layout() {
        let titleLabelView = SPTitleView(title: "반가워요, 닉네임 님!", subtitle: "오늘도 SpeaKing과 함께 달려볼까요?")
        
        addSubview(titleLabelView)
        
        titleLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(newSpeakingButton)
        
        newSpeakingButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabelView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(100)
        }
    }
}
