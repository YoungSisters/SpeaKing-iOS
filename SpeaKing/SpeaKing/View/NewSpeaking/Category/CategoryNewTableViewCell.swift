//
//  CategoryNewTableViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/15.
//

import UIKit

class CategoryNewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CategoryNewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: FontSize.body)
        label.text = "새 카테고리 만들기"
        label.textColor = Color.Main
        
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.setImageColor(color: Color.Main!)
        
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CategoryNewTableViewCell {
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
