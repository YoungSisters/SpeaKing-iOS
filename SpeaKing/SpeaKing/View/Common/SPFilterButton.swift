//
//  SPFilterButton.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/11.
//

import UIKit

class SPFilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
//        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SPFilterButton {
    func style() {
        self.titleLabel?.font = .systemFont(ofSize: FontSize.subhead)
        self.tintColor = Color.Main
        
        self.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)

        self.semanticContentAttribute = .forceRightToLeft
    }
}
