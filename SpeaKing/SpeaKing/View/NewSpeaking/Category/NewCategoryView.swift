//
//  NewCategoryView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/16.
//

import UIKit

protocol NewCategoryViewDelegate {
    func createNewCategory(categoryName name: String)
}

class NewCategoryView: UIView {
    
    var titleLabel = SPTitleView(title: "카테고리 이름", subtitle: nil)
    
    var textField = SPTextField(placeholder: "최대 20자까지 입력 가능해요")
    
    lazy var doneButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    var delegate: NewCategoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension NewCategoryView {
    func style() {
        self.backgroundColor = Color.Background
        self.dismissKeyboardWhenTappedAround()
    }
    
    func layout() {
        addSubview(doneButton)

        doneButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc func doneButtonTapped() {
        guard let name = textField.text else {
            return
        }
        
        if !name.isEmpty {
            delegate?.createNewCategory(categoryName: name)
        }
    }
}
