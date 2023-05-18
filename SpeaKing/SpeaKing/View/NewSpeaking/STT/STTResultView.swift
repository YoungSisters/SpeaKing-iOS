//
//  STTResultView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/17.
//

import UIKit

class STTResultView: UIView {
    
    private var titleView = SPTitleView(title: "텍스트로 변환한 결과예요.", subtitle: "잘못 변환된 단어가 있으면 수정해주세요.")
    
    private var textView = SPResultTextView()
    
    private var playerView = SPPlayerView()
    
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
    
    // Properties
    
    var recordTitle: String
    var resultText: String
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        style()
//        layout()
//    }
    
    required init(recordTitle: String, resultText: String) {
        self.recordTitle = recordTitle
        self.resultText = resultText
        
        super.init(frame: .zero)
        
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
        
        self.playerView.setTitle(title: recordTitle)
        self.textView.setTextViewText(text: resultText)
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
    
//    func setResultText(result text: String) {
//        textView.setTextViewText(text: text)
//    }
}
