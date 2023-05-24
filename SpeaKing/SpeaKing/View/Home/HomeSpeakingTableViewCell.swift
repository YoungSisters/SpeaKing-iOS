//
//  HomeSpeakingTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/12.
//

import UIKit
import SnapKit

class HomeSpeakingTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "speakingCell"
    
    var speakingCellView = HomeSpeakingCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeSpeakingTableViewCell {
    func layout() {
        addSubview(speakingCellView)
        
        speakingCellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setSpeakingData(data: SpeakingListResultModel) {
        self.speakingCellView.setSpeakingData(data: data)
    }
}
