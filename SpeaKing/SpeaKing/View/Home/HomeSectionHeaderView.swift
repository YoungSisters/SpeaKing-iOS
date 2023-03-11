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
    
//    lazy var searchTextField: UIS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        style()
        configureSearchTextField()
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
    }
}
