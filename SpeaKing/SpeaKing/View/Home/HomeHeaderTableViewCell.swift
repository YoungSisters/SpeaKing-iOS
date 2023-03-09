//
//  HomeHeaderTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/09.
//

import UIKit
import SnapKit

class HomeHeaderTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "headerCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.Main
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func setTitleLabel() {
        titleLabel.attributedText = NSMutableAttributedString()
            .title(string: "반가워요, 닉네임 님!")
            .subtitle(string: "오늘도 SpeaKing과 함께 달려볼까요?")
    }

}
