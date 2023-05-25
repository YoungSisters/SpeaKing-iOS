//
//  GrammarResultSwitchView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/26.
//

import UIKit

import SnapKit

class GrammarResultSwitchView: UIView {
    
    private var switchTitle: UILabel = {
        let label = UILabel()
        
        label.text = "결과 보기"
        label.textColor = Color.Main
        label.font = .systemFont(ofSize: FontSize.subhead)
        
        return label
    }()
    
    var resultSwitch: UISwitch = {
        let sw = UISwitch()
        
        sw.onTintColor = Color.Purple
        sw.tintColor = Color.LightPurple
        
        return sw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
//    }
}

extension GrammarResultSwitchView {
    func style() {
        resultSwitch.set(width: 41, height: 24)
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [switchTitle, resultSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension UISwitch {
    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
