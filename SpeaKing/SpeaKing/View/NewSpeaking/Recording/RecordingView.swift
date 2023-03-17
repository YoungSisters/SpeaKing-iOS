//
//  RecordingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class RecordingView: UIView {
    
    var micView = RecordingMicView()
    
    lazy var speakingTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "SpeaKING"
        label.textColor = Color.Main
        label.font = .systemFont(ofSize: FontSize.body)
        
        return label
    }()
    
    lazy var speakingTimeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "00:00"
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = Color.White
        button.addShadow()
        button.tintColor = Color.Main
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = Color.Purple
        button.addShadow()
        button.tintColor = Color.White
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = Color.White
        button.addShadow()
        button.tintColor = Color.Main
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        configureMicView()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

// MARK: - Setup
extension RecordingView {
    func style() {
        self.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(micView)
        
        micView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(140)
            make.centerX.equalToSuperview()
            make.size.equalTo(230)
        }
        
        let labelStackView = UIStackView(arrangedSubviews: [speakingTitleLabel, speakingTimeLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        labelStackView.alignment = .center
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(micView.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
        }
        
        stopButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.size.equalTo(60)
        }
        
        doneButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [stopButton, pauseButton, doneButton])
        
        buttonStackView.spacing = 32
        buttonStackView.alignment = .center
        
        addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureMicView() {
        micView.layer.cornerRadius = 230 / 2
    }
    
    func configureButtons() {
        stopButton.layer.cornerRadius = 50 / 2
        pauseButton.layer.cornerRadius = 60 / 2
        doneButton.layer.cornerRadius = 50 / 2
    }
}
