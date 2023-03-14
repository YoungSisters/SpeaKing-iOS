//
//  SPBottomButton.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class SPBottomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 16
        self.backgroundColor = Color.Purple
        self.titleLabel?.font = .boldSystemFont(ofSize: FontSize.body)
        self.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
