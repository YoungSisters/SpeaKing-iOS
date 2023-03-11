//
//  HomeSectionHeaderView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/11.
//

import UIKit

class HomeSectionHeaderView: UIView {
    
    var titleLabelView = SPTitleView(title: "나의 SpeaKing", subtitle: nil)
    var searchTextField = SPTextField(placeholder: "나의 Speaking 검색")
    
    lazy var mySpeakingCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0개의 SpeaKing"
        label.font = .systemFont(ofSize: FontSize.subhead)
        label.textColor = Color.Main
        
        return label
    }()
    
    var mySpeakingFilterButton = SPFilterButton(type: .system)
    var mySpeakingOrderFilterButton = SPFilterButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSearchTextField()
        configureFilterButtons()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension HomeSectionHeaderView {
    func configureSearchTextField() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 45))        
        let imageView = UIImageView(frame: CGRect(x: 16, y: 14, width: 16, height: 16))
        
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.setImageColor(color: Color.Gray!)
        imageView.contentMode = .scaleAspectFit
        
        leftView.addSubview(imageView)
        
        searchTextField.leftView = leftView
    }
    
    func configureFilterButtons() {
        mySpeakingFilterButton.setTitle("전체", for: .normal)
        mySpeakingOrderFilterButton.setTitle("최신순", for: .normal)
    }
    
    func layout() {
        addSubview(titleLabelView)
        
        titleLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabelView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(mySpeakingCountLabel)
        
        mySpeakingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        
        let stackView = UIStackView(arrangedSubviews: [mySpeakingFilterButton, mySpeakingOrderFilterButton])
        
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
