//
//  SPTextField.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/11.
//

import UIKit
import SnapKit

class SPTextField: UITextField {
    
    required init(placeholder: String) {
        super.init(frame: CGRect.zero)

        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: Color.Gray!]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 45)
    }
}

extension SPTextField {
    func style() {
        backgroundColor = Color.White
        self.layer.cornerRadius = 16
        
        self.font = .systemFont(ofSize: 16)
        self.textColor = Color.Main
        
        self.addShadow()
        self.addLeftPadding()
    }
}
