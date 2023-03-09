//
//  NewSpeakingButtonView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/09.
//

import UIKit

class NewSpeakingButtonView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "새 SpeaKing 시작하기"
        label.font = UIFont.boldSystemFont(ofSize: FontSize.body)
        label.textColor = Color.White
        label.sizeToFit()
        return label
    }()
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.setImageColor(color: Color.White!)
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints { make in
            make.size.width.height.equalTo(8)
        }

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
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension NewSpeakingButtonView {
    func style() {
        self.backgroundColor = Color.Purple
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, chevronImageView])
        stackView.alignment = .center
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.height.equalTo(titleLabel.snp.height)
            make.leading.equalToSuperview().offset(32)
            make.centerY.equalToSuperview()
        }
    }
}
