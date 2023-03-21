//
//  PronunciationScoreCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

class PronunciationScoreCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PronunciationScoreCell"
    
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

extension PronunciationScoreCollectionViewCell {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        
    }
}
