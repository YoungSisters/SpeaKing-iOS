//
//  RecordingMicView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class RecordingMicView: UIView {
    
    lazy var micImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "mic.fill")
        imageView.setImageColor(color: Color.Purple!)
        
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

extension RecordingMicView {
    func style() {
        self.backgroundColor = Color.White
        self.addShadow()
    }
    
    func layout() {
        addSubview(micImageView)
        
        micImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(120)
        }
    }
}
