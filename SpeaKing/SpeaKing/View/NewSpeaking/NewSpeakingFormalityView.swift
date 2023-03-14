//
//  NewSpeakingFormalityView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

class NewSpeakingFormalityView: UIView {
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        
        label.text = "💼"
        label.font = .systemFont(ofSize: 32)
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Formal"
        label.font = .boldSystemFont(ofSize: FontSize.body)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "💼"
        label.font = .systemFont(ofSize: FontSize.subhead)
        
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 80)
    }

}

extension NewSpeakingFormalityView {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        addSubview(iconLabel)
        
        iconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
