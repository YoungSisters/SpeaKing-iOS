//
//  HomeHeaderView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/10.
//

import UIKit

class HomeHeaderView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.Main
        label.numberOfLines = 0

        return label
    }()
    
    var newSpeakingButton = NewSpeakingButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        layout()
        setTitleLabel()
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
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        addSubview(newSpeakingButton)
        
        newSpeakingButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(100)
        }
    }
    
    func setTitleLabel() {
        titleLabel.attributedText = NSMutableAttributedString()
            .title(string: "반가워요, 닉네임 님!")
            .subtitle(string: "오늘도 SpeaKing과 함께 달려볼까요?")
        titleLabel.sizeToFit()
    }
}
