//
//  SpeakingResultView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

enum SpeakingResultCollectionViewSection: Int {
    case textView = 0
    case pronunciationScore
    case speed
    case vocabulary
    case formality
}

class SpeakingResultView: UIView {
    private let headerTitle = ["문법 검사", "발음 점수", "말하기 속도", "자주 사용한 단어", "나의 문장 Check"]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(SpeakingResultCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SpeakingResultCollectionReusableView.identifier)
        
        collectionView.register(GrammarCollectionViewCell.self, forCellWithReuseIdentifier: GrammarCollectionViewCell.cellIdentifier)
        collectionView.register(PronunciationScoreCollectionViewCell.self, forCellWithReuseIdentifier: PronunciationScoreCollectionViewCell.cellIdentifier)
        collectionView.register(SpeakingSpeedCollectionViewCell.self, forCellWithReuseIdentifier: SpeakingSpeedCollectionViewCell.cellIdentifier)
        collectionView.register(VocabularyCollectionViewCell.self, forCellWithReuseIdentifier: VocabularyCollectionViewCell.cellIdentifier)
        collectionView.register(FormalityCheckCollectionViewCell.self, forCellWithReuseIdentifier: FormalityCheckCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 32
        
        return layout
    }()

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
    
    // MARK: - Properties
    
    var delegate: PlayerDelegate?
    
    private var shouldGrammarResultShown = false
    
    private var speakingResult: NewSpeakingResultModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
        addPlayerComponentTargets()
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

// MARK: - Setup

extension SpeakingResultView {
    func style() {
        self.backgroundColor = Color.Background
        self.playerView.setTitle(title: speakingResult?.title ?? "SpeaKing")
    }
    
    func layout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        addSubview(playerBackgroundView)
        
        playerBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setup Collection View

extension SpeakingResultView {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionView Delegate and DataSource

extension SpeakingResultView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SpeakingResultCollectionViewSection(rawValue: section) else { return 0 }
        
        return section == .formality ? speakingResult?.nlp.count ?? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section),
              let result = speakingResult else {
            assert(false)
        }
        
        switch section {
        case .textView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GrammarCollectionViewCell.cellIdentifier, for: indexPath) as! GrammarCollectionViewCell
            
            cell.resultTextView.setTextViewText(text: shouldGrammarResultShown ? result.correctedText : result.text)
            
            return cell
            
        case .pronunciationScore:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PronunciationScoreCollectionViewCell.cellIdentifier, for: indexPath) as! PronunciationScoreCollectionViewCell
            
            cell.setPronunciationScore(score: result.pronunciation)
            
            return cell
            
        case .speed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpeakingSpeedCollectionViewCell.cellIdentifier, for: indexPath) as! SpeakingSpeedCollectionViewCell
            
            cell.setSpeakingSpeed(isFormal: result.selectedformality == "Formality", speed: result.speed)
            
            return cell
            
        case .vocabulary:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VocabularyCollectionViewCell.cellIdentifier, for: indexPath) as! VocabularyCollectionViewCell
            
            if let data = result.wordFrequency {
                cell.setWordData(data: data)
            }
            
            return cell
            
        case .formality:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormalityCheckCollectionViewCell.cellIdentifier, for: indexPath) as! FormalityCheckCollectionViewCell
            
            let data = result.nlp[indexPath.row]
            
            cell.setResult(before: data.sentence, after: data.paraphrasing, isFormal: data.formality == "Formal" ? true : false)
      
            return cell
        }
    }
    
    
    // MARK: sizeForItemAt
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section), let result = speakingResult else {
            assert(false)
            return CGSize()
        }
        
        let width = collectionView.frame.width - 32

        switch section {
        case .textView:
            return CGSize(width: width, height: 300)
        case .pronunciationScore:
            return CGSize(width: width, height: 125)
        case .speed:
            return CGSize(width: width, height: 145)
        case .vocabulary:
            return CGSize(width: width, height: 200)
        case .formality:
            let length = result.nlp[indexPath.row].sentence.count
            var height = 200.0
            if length <= 40 {
                height = 200
            } else if length <= 88 {
                height = 250
            } else {
                height = 300
            }
            print()
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: Sections
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SpeakingResultCollectionReusableView.identifier, for: indexPath) as! SpeakingResultCollectionReusableView
            headerView.setTitleLabelText(text: headerTitle[indexPath.section])
            headerView.isGrammar = indexPath.section == 0
            headerView.isSwitchOn = self.shouldGrammarResultShown
            headerView.addSwitchTarget(self, action: #selector(switchValueChanged))
            
            return headerView
        default:
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: 50)
    }
}

// MARK: - Grammar Switch
extension SpeakingResultView {
    @objc func switchValueChanged(_ sender: UISwitch) {
        shouldGrammarResultShown = sender.isOn
        UIView.performWithoutAnimation({
            self.collectionView.reloadSections([0])
        })
    }
}

// MARK: - PlayerView Targets

extension SpeakingResultView {
    func addPlayerComponentTargets() {
        playerView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        playerView.backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        playerView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        playerView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc func forwardButtonTapped() {
        delegate?.seekForward()
    }
    
    @objc func backwardButtonTapped() {
        delegate?.seekBackward()
    }
    
    @objc func pauseButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            delegate?.playAudio()
        } else {
            delegate?.pauseAudio()
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = TimeInterval(sender.value)
        setCurrentTime(time: value)
        
        if sender.isTracking {
            return
        }
        
        delegate?.movePlaytime(time: value)
    }
}

// MARK: - Communicate with view controller

extension SpeakingResultView {
    func setSpeakingResult(result: NewSpeakingResultModel) {
        self.speakingResult = result
        self.playerView.setTitle(title: speakingResult?.title ?? "SpeaKing")
        self.collectionView.reloadData()
    }
    
    func setOverallDuration(duration: TimeInterval) {
        playerView.totalTimeLabel.text = duration.stringFromTimeInterval()
        playerView.slider.maximumValue = Float(duration)
        playerView.slider.isContinuous = true
    }
    
    func setCurrentTime(time: TimeInterval) {
        guard !playerView.slider.isTracking else {
            return
        }
        
        playerView.slider.value = Float(time)
        playerView.currentTimeLabel.text = time.stringFromTimeInterval()
    }
    
    func resetPlayer() {
        playerView.pauseButton.isSelected = false
        playerView.slider.value = 0
        playerView.currentTimeLabel.text = 0.stringFromTimeInterval()
    }
}
