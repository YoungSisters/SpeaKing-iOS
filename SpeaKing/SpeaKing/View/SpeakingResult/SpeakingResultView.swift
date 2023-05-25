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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.separatorStyle = .none

        tableView.backgroundColor = .clear
        
        tableView.register(SpeakingResultCollectionReusableView.self, forHeaderFooterViewReuseIdentifier: SpeakingResultCollectionReusableView.identifier)
        tableView.register(GrammarCollectionViewCell.self, forCellReuseIdentifier: GrammarCollectionViewCell.cellIdentifier)
        tableView.register(PronunciationScoreCollectionViewCell.self, forCellReuseIdentifier: PronunciationScoreCollectionViewCell.cellIdentifier)
        tableView.register(SpeakingSpeedCollectionViewCell.self, forCellReuseIdentifier: SpeakingSpeedCollectionViewCell.cellIdentifier)
        tableView.register(VocabularyCollectionViewCell.self, forCellReuseIdentifier: VocabularyCollectionViewCell.cellIdentifier)
        tableView.register(FormalityCheckCollectionViewCell.self, forCellReuseIdentifier: FormalityCheckCollectionViewCell.cellIdentifier)
        
        return tableView
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
        
        configureTableView()
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
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
//            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(playerBackgroundView)
        
        playerBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setup Collection View

extension SpeakingResultView {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UICollectionView Delegate and DataSource

extension SpeakingResultView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section) else { return CGFloat() }
        
        switch section {
        case .textView:
            return 250
        case .pronunciationScore:
            return 125
        case .speed:
            return 145
        case .vocabulary:
            return 200
        case .formality:
            return 225
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension SpeakingResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SpeakingResultCollectionViewSection(rawValue: section) else { return 0 }
        
        return section == .formality ? speakingResult?.nlp.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section),
              let result = speakingResult else {
            assert(false)
        }
        
        switch section {
        case .textView:
            let cell = tableView.dequeueReusableCell(withIdentifier: GrammarCollectionViewCell.cellIdentifier, for: indexPath) as! GrammarCollectionViewCell
            
            cell.resultTextView.setTextViewText(text: shouldGrammarResultShown ? result.correctedText : result.text)
            
            return cell
            
        case .pronunciationScore:
            let cell = tableView.dequeueReusableCell(withIdentifier: PronunciationScoreCollectionViewCell.cellIdentifier, for: indexPath) as! PronunciationScoreCollectionViewCell
            
            cell.setPronunciationScore(score: result.pronunciation)
            
            return cell
            
        case .speed:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpeakingSpeedCollectionViewCell.cellIdentifier, for: indexPath) as! SpeakingSpeedCollectionViewCell
            
            cell.setSpeakingSpeed(speed: result.speed)
            
            return cell
            
        case .vocabulary:
            let cell = tableView.dequeueReusableCell(withIdentifier: VocabularyCollectionViewCell.cellIdentifier, for: indexPath) as! VocabularyCollectionViewCell
            
            if let data = result.wordFrequency {
                cell.setWordData(data: data)
            }
            
            return cell
            
        case .formality:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormalityCheckCollectionViewCell.cellIdentifier, for: indexPath) as! FormalityCheckCollectionViewCell
            
            let data = result.nlp[indexPath.row]
            
            cell.setResult(before: data.sentence, after: data.paraphrasing, isFormal: data.formality == "Formal" ? true : false)
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SpeakingResultCollectionReusableView.identifier) as! SpeakingResultCollectionReusableView
        headerView.setTitleLabelText(text: headerTitle[section])
        headerView.isGrammar = section == 0
        headerView.isSwitchOn = self.shouldGrammarResultShown
        headerView.addSwitchTarget(self, action: #selector(switchValueChanged))
        
        return headerView
    }
}

// MARK: - Grammar Switch
extension SpeakingResultView {
    @objc func switchValueChanged(_ sender: UISwitch) {
        shouldGrammarResultShown = sender.isOn
        tableView.reloadSections([0], with: .none)
//        UIView.performWithoutAnimation({
//            self.collectionView.reloadSections([0])
//        })
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
        self.tableView.reloadData()
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
