//
//  HomeSpeakingCellView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/12.
//

import UIKit

class HomeSpeakingCellView: UIView {
    
    private var speakingData: SpeakingListResultModel?
    
    private var categoryStackView = MySpeakingStackView(image: UIImage(systemName: "folder"), name: "카테고리")
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "SpeaKing"
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.body)
        
        return label
    }()
    
    var timeStackView = MySpeakingStackView(image: UIImage(systemName: "clock"), name: "00:00")
    var dateStackView = MySpeakingStackView(image: UIImage(systemName: "mic"), name: "0000년 00월 00일")

    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.layer.cornerRadius = 48 / 2
        button.backgroundColor = Color.Purple
        button.tintColor = Color.White
        
        return button
    }()
    
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

extension HomeSpeakingCellView {
    func style() {
        self.layer.cornerRadius = 16
        self.backgroundColor = Color.White
        self.addShadow()
    }
    
    func layout() {
        let detailStackView = UIStackView(arrangedSubviews: [timeStackView, dateStackView])
        detailStackView.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [categoryStackView, titleLabel, detailStackView])
        
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        addSubview(playButton)
        
        playButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.size.equalTo(48)
        }
    }
    
    func setSpeakingData(data: SpeakingListResultModel) {
        self.speakingData = data
        titleLabel.text = data.title
        categoryStackView.setLabelText(text: data.categoryName)
        timeStackView.setLabelText(text: data.recordTime)
        dateStackView.setLabelText(text: data.saveDate)
    }
}
