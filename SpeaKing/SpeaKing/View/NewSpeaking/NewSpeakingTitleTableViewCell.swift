//
//  NewSpeakingTitleTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

class NewSpeakingTitleTableViewCell: UITableViewCell {
    
    lazy var titleTextField: SPTextField = {
        let textField = SPTextField(placeholder: "최대 20자까지 입력 가능해요.")
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension NewSpeakingTitleTableViewCell {
    func style() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func layout() {
        addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
