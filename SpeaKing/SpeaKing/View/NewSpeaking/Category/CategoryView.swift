//
//  CategoryView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class CategoryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

}

extension CategoryView {
    func style() {
        backgroundColor = .orange
    }
    
    func layout() {
        
    }
}
