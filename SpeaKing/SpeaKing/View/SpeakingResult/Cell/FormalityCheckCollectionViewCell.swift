//
//  FormalityCheckCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/23.
//

import UIKit

class FormalityCheckCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "FormalityCheckCell"
    
    private var beforeSentenceView = FormalitySentenceView(isBefore: true)
    private var afterSentenceView = FormalitySentenceView(isBefore: false)
    
    lazy var separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Color.Background
        
        return view
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

// MARK: - Setup

extension FormalityCheckCollectionViewCell {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [beforeSentenceView, separatorView, afterSentenceView])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        addSubview(stackView)
        
        separatorView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setResult(before: String, after: String, isFormal: Bool) {
        beforeSentenceView.setBeforeResult(sentence: before, isFormal: isFormal)
        afterSentenceView.setAfterResult(sentence: after)
    }
}
