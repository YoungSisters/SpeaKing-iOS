//
//  STTResultView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class STTResultView: UIView {
    
    var titleView = SPTitleView(title: "텍스트로 변환한 결과예요.", subtitle: "잘못 변환된 단어가 있으면 수정해주세요.")
    
    var textView = SPResultTextView()
    
    var playerView = SPPlayerView()
    
    lazy var playerBackgroundView: UIView = {
        let view = UIView()
        view.addShadow()
        view.layer.cornerRadius = 16
        view.backgroundColor = Color.White
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var nextButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("다음", for: .normal)
        
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

extension STTResultView {
    func style() {
        self.backgroundColor = Color.Background
        self.dismissKeyboardWhenTappedAround()
        textView.textView.text = "Well I can remember as a small child probably between the age of three and seven going to Asheville and visit my grandmother uh umm and uh my grandfather but he died when I was fairly young so I mostly remember visiting my grandmother. She lived in a small house at Asheville. The uh the small  neighborhood I remember she lived in was very uh quiet mostly older people and uh we used to go around the small neighborhood and visit lot of her old friends. "
    }
    
    func layout() {
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.lessThanOrEqualTo(330)
        }
        
        addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(playerBackgroundView)
        
        playerBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(nextButton.snp.top).offset(-32)
        }
    }
}
