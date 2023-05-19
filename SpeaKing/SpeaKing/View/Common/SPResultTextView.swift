//
//  SPResultTextView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class SPResultTextView: UIView {
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = Color.Main
        textView.textAlignment = .justified
        textView.showsVerticalScrollIndicator = false
        
        return textView
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

extension SPResultTextView {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        addShadow()
    }
    
    func layout() {
        addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension SPResultTextView {
    func setTextViewText(text: String) {
        guard let str = try? NSAttributedString(markdown: text) else {
            return
        }
        
        let attributedText = NSMutableAttributedString(attributedString: str)
        attributedText.addAttributes([.font: UIFont.systemFont(ofSize: FontSize.body), .foregroundColor: Color.Main!], range: NSMakeRange(0, attributedText.length))
        
        self.textView.attributedText = attributedText
//        self.textView.text = text
    }
}
