//
//  SpeakingResultCollectionReusableView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/21.
//

import UIKit

class SpeakingResultCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderView"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title"
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.title)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
//    }
}

extension SpeakingResultCollectionReusableView {
    func style() {
        self.backgroundColor = .clear
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    func setTitleLabelText(text: String) {
        self.titleLabel.text = text
    }
}
