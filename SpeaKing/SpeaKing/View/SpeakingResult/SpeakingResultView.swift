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
    
    private let headerTitle = ["문법 검사", "발음 점수", "말하기 속도", "자주 사용한 단어", "Formality 검사"]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(SpeakingResultCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SpeakingResultCollectionReusableView.identifier)
        
        collectionView.register(SpeakingResultTextViewCollectionViewCell.self, forCellWithReuseIdentifier: SpeakingResultTextViewCollectionViewCell.cellIdentifier)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
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
        
        return section == .formality ? 3 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section) else {
            assert(false)
        }
        
        switch section {
        case .textView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpeakingResultTextViewCollectionViewCell.cellIdentifier, for: indexPath) as! SpeakingResultTextViewCollectionViewCell
            
            cell.resultTextView.setTextViewText(text: "Well I can remember as a small child probably between the age of three and seven going to Asheville and visit my grandmother uh umm and uh my grandfather but he died when I was fairly young so I mostly remember visiting my grandmother. She lived in a small house at Asheville. The uh the small  neighborhood I remember she lived in was very uh quiet mostly older people and uh we used to go around the small neighborhood and visit lot of her old friends. ")
            
            return cell
        case .pronunciationScore:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PronunciationScoreCollectionViewCell.cellIdentifier, for: indexPath) as! PronunciationScoreCollectionViewCell
            
            return cell
        case .speed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpeakingSpeedCollectionViewCell.cellIdentifier, for: indexPath) as! SpeakingSpeedCollectionViewCell
            
            return cell
        case .vocabulary:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VocabularyCollectionViewCell.cellIdentifier, for: indexPath) as! VocabularyCollectionViewCell
            
            return cell
        case .formality:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormalityCheckCollectionViewCell.cellIdentifier, for: indexPath) as! FormalityCheckCollectionViewCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = SpeakingResultCollectionViewSection(rawValue: indexPath.section) else { return CGSize() }
        
        let width = collectionView.frame.width - 32

        switch section {
        case .textView:
            return CGSize(width: width, height: 330)
        case .pronunciationScore:
            return CGSize(width: width, height: 125)
        case .speed:
            return CGSize(width: width, height: 145)
        case .vocabulary:
            return CGSize(width: width, height: 200)
        case .formality:
            return CGSize(width: width, height: 200)
        }
    }
    
    // Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SpeakingResultCollectionReusableView.identifier, for: indexPath) as! SpeakingResultCollectionReusableView
            headerView.setTitleLabelText(text: headerTitle[indexPath.section])
            return headerView
        default:
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: 50)
    }
}
