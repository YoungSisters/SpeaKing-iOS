//
//  NewSpeakingCategorySelectionView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

class NewSpeakingCategorySelectionView: UIView {
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "카테고리 선택"
        label.font = .systemFont(ofSize: 16)
        label.textColor = Color.Gray
        
        return label
    }()
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.setImageColor(color: Color.Gray!)
        
        return imageView
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
        return CGSize(width: UIView.noIntrinsicMetric, height: 45)
    }

}

extension NewSpeakingCategorySelectionView {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(chevronImageView)
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
