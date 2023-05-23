//
//  FormalitySentenceView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/23.
//

import UIKit

class FormalitySentenceView: UIView {
    
    var isBefore: Bool
    
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
    
    private lazy var formalLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Type"
        label.textColor = Color.White
        label.font = .preferredFont(forTextStyle: .footnote)
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var formalView: UIView = {
        let view = UIView()
        
        view.addSubview(formalLabel)
        formalLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        view.backgroundColor = Color.Darkgray
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
    
    init(isBefore: Bool) {
        self.isBefore = isBefore

        super.init(frame: .zero)
                
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        typeView.layer.cornerRadius = typeView.frame.height / 2
        formalView.layer.cornerRadius = formalView.frame.height / 2
    }
}

extension FormalitySentenceView {
    func style() {
//        if isBefore {
//            typeView.backgroundColor = Color.LightPurple
//            typeLabel.text = "Before"
//            formalView.isHidden = false
//            if let isFormal = isFormal {
//                formalLabel.text = isFormal ? "Formal" : "Informal"
//            }
//            
//        } else {
//            typeView.backgroundColor = Color.Purple
//            typeLabel.text = "After"
//            formalView.isHidden = true
//        }
    }
    
    func layout() {
        let topStackView = UIStackView(arrangedSubviews: [typeView, formalView])
        
        topStackView.axis = .horizontal
        topStackView.alignment = .leading
        topStackView.spacing = 8
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, sentenceLabel])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setBeforeResult(sentence: String, isFormal: Bool) {
        typeView.backgroundColor = Color.LightPurple
        typeLabel.text = "Before"
        formalView.isHidden = false
        formalLabel.text = isFormal ? "Formal" : "Informal"
        sentenceLabel.text = sentence
    }
    
    func setAfterResult(sentence: String) {
        typeView.backgroundColor = Color.Purple
        typeLabel.text = "After"
        formalView.isHidden = true
        sentenceLabel.text = sentence
    }
}
