//
//  SPLoadingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

import Lottie

enum AnimationType: String {
    case loading = "LoadingBar"
    case done = "Done"
}

class SPLoadingView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "로딩 중"
        label.numberOfLines = 0
        label.textColor = Color.Main
        label.font = .boldSystemFont(ofSize: FontSize.title)
        
        return label
    }()
    
    lazy var doneButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("확인", for: .normal)
        
        return button
    }()
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var isDoneButtonHidden: Bool {
        get {
            return doneButton.isHidden
        }
        set {
            doneButton.isHidden = newValue
        }
    }
    
    required init(title: String, buttonTitle: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        doneButton.setTitle(buttonTitle, for: .normal)
        
        style()
        layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension SPLoadingView {
    func style() {
        self.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(134)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setAnimation(type: AnimationType) {
        let animationView = LottieAnimationView(name: type.rawValue)
        
        animationView.contentMode = .scaleAspectFill
        
        addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(64)
            make.top.equalTo(titleLabel.snp.bottom).offset(64)
            make.height.equalTo(200)
        }
        
        animationView.loopMode = type == .loading ? .loop : .playOnce
        
        animationView.play()
    }
}
