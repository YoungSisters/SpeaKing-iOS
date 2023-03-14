//
//  NewSpeakingFormalityTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

class NewSpeakingFormalityTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FormalityCell"
    
    var formalityView = NewSpeakingFormalityView()
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.formalityView.layer.borderWidth = 2
            self.formalityView.layer.borderColor = Color.Purple?.cgColor
        } else {
            self.formalityView.layer.borderWidth = 0
        }
        
    }

}

extension NewSpeakingFormalityTableViewCell {
    func style() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func layout() {
        addSubview(formalityView)
        
        formalityView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
