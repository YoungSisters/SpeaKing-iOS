//
//  CategoryTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/15.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CategoryCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = Color.Main
        
        return label
    }()
    
    var iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            iconImageView.image = UIImage(systemName: "checkmark.circle.fill")
            iconImageView.setImageColor(color: Color.Purple!)
        } else {
            iconImageView.image = UIImage()
        }
    }

}

extension CategoryTableViewCell {
    func style() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func layout() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.greaterThanOrEqualTo(iconImageView.snp.leading).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
