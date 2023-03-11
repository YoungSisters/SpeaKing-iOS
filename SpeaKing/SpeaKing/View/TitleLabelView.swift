//
//  TitleLabelView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/11.
//

import UIKit
import SnapKit

class TitleLabelView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.title)
        label.numberOfLines = 0

        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.Main
        label.font = .systemFont(ofSize: FontSize.body)
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }()
    
    required init(title: String, subtitle: String?) {
        super.init(frame: CGRect.zero)
        
        titleLabel.text = title
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        }
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension TitleLabelView {
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.spacing = 4
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
