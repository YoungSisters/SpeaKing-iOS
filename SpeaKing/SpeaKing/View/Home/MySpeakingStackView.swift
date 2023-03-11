//
//  MySpeakingStackView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/12.
//

import UIKit

class MySpeakingStackView: UIStackView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "HELLO"
        label.textColor = Color.Darkgray
        label.font = .systemFont(ofSize: FontSize.caption)
        label.sizeToFit()
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setImageColor(color: Color.Darkgray!)
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(10)
        }
        
        return imageView
    }()
    
    required init(image: UIImage?, name: String) {
        super.init(frame: CGRect.null)
        
        label.text = name
        imageView.image = image
        
        configureStackView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
//        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MySpeakingStackView {
    func configureStackView() {
        self.addArrangedSubview(imageView)
        self.addArrangedSubview(label)
        
        self.distribution = .equalCentering
        self.spacing = 2
    }
}
