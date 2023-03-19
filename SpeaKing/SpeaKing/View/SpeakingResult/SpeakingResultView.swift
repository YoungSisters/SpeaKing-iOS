//
//  SpeakingResultView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit
import SnapKit

class SpeakingResultView: UIView {
    
    var playerView = SPPlayerView()
    
    lazy var playerBackgroundView: UIView = {
        let view = UIView()
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalToSuperview().inset(16)
        }
        view.backgroundColor = Color.White
        view.addShadow()
        
        return view
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

extension SpeakingResultView {
    func style() {
        self.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(playerBackgroundView)
        
        playerBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
//            make.height.equalTo(205)
        }
    }
}
