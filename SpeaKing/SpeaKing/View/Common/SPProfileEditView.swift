//
//  SPProfileEditView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/01.
//

import UIKit

class SPProfileEditView: UIView {
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.layer.cornerRadius = 100 / 2
        imageView.addShadow()
        imageView.tintColor = Color.LightPurple
        
        return imageView
    }()
    
    lazy var editView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        view.backgroundColor = Color.White
        view.layer.cornerRadius = 24 / 2
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Color.Purple
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
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
        return CGSize(width: 100, height: 100)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        editView.layer.cornerRadius = editView.frame.width / 2
        editView.clipsToBounds = true
    }
}

extension SPProfileEditView {
    func style() {
        addShadow()
    }
    
    func layout() {
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(editView)
        
        editView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(profileImageView).offset(5)
            make.trailing.equalTo(profileImageView)
        }
    }
}
