//
//  SPLoadingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class SPLoadingView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "로딩 중"
        label.numberOfLines = 0
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.title)
        
        return label
    }()
    
    lazy var doneButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("확인", for: .normal)
        
        return button
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

extension SPLoadingView {
    func style() {
        self.backgroundColor = Color.Background
        doneButton.isHidden = true
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(134)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
}
