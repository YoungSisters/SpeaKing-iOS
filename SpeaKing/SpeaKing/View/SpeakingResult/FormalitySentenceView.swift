//
//  FormalitySentenceView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/23.
//

import UIKit

class FormalitySentenceView: UIView {
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Type"
        label.textColor = Color.White
        label.font = .preferredFont(forTextStyle: .footnote)
        label.sizeToFit()
        
        return label
    }()
    
    lazy var typeView: UIView = {
        let view = UIView()
        
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        
        view.backgroundColor = Color.Purple
        view.addShadow()
        
        return view
    }()
    
    lazy var sentenceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sentence"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = Color.Main
        label.numberOfLines = 0
        
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        typeView.layer.cornerRadius = typeView.frame.height / 2
    }
}

extension FormalitySentenceView {
    
    func style() {
        
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [typeView, sentenceLabel])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
