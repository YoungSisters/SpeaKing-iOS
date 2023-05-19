//
//  SpeakingResultLoadingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

protocol SpeakingResultLoadingViewDelegate {
    func pushNextViewController()
}

class SpeakingResultLoadingView: UIView {
    
    var loadingView = SPLoadingView(title: "SpeaKing이\n사용자 님의 말하기를\n분석하고 있어요.", buttonTitle: "결과 확인하기")
    
    var delegate: SpeakingResultLoadingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
        loadingView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            print("Timer")
            self.loadingView.title = "SpeaKing이\n\(UserDefaultsManager.getData(type: String.self, forKey: .nickname) ?? "사용자") 님의 말하기를\n분석했어요."
            self.loadingView.setAnimation(type: .done)
            self.loadingView.isDoneButtonHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension SpeakingResultLoadingView {
    func style() {
        loadingView.setAnimation(type: .loading)
        loadingView.isDoneButtonHidden = true
    }
    
    func layout() {
        addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func doneButtonTapped() {
        delegate?.pushNextViewController()
    }
}
