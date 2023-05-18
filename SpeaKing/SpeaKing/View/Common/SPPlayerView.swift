//
//  STTPlayerView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

protocol PlayerDelegate {
    func seekForward()
    func seekBackward()
    func playAudio()
    func pauseAudio()
    func movePlaytime(time: TimeInterval)
}

class SPPlayerView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "녹음 제목"
        label.font = .boldSystemFont(ofSize: FontSize.title3)
        label.textColor = Color.Main
        
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        let thumb = UIImage(systemName: "circle.fill")?.withTintColor(Color.Purple!, renderingMode: .alwaysOriginal)
        
        slider.minimumValue = 0
        slider.minimumTrackTintColor = Color.LightPurple
        slider.maximumTrackTintColor = Color.Gray
        slider.setThumbImage(thumb, for: .normal)
        slider.addShadow()
        
        return slider
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: FontSize.caption)
        
        return label
    }()
    
    lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: FontSize.caption)
        
        return label
    }()
    
    lazy var backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = Color.Main
        
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        button.tintColor = Color.White
        button.backgroundColor = Color.Purple
        button.layer.cornerRadius = 50 / 2
        button.addShadow()
        
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = Color.Main
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButtons()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

}

extension SPPlayerView {
    func configureButtons() {
        backwardButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        addSubview(slider)
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(currentTimeLabel)
        
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(4)
            make.leading.equalTo(slider.snp.leading)
        }
        
        addSubview(totalTimeLabel)
        
        totalTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(4)
            make.trailing.equalTo(slider.snp.trailing)
        }
        let stackView = UIStackView(arrangedSubviews: [backwardButton, pauseButton, forwardButton])
        
        stackView.spacing = 32
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalTimeLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
    }
}

extension SPPlayerView {
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
