//
//  SpeakingResultTextViewCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

class GrammarCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "grammarCell"

    var resultTextView = SPResultTextView()
    
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

extension GrammarCollectionViewCell {
    func style() {
        self.backgroundColor = .clear
        resultTextView.textView.isEditable = false
    }
    
    func layout() {
        addSubview(resultTextView)
        
        resultTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
