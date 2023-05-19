//
//  PronunciationScoreCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit

import Charts

class PronunciationScoreCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PronunciationScoreCell"
    
    var chartView = PieChartView()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        
        let userScoreAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: FontSize.title3),
            .foregroundColor: Color.Main!
        ]
        
        let userScoreString = NSAttributedString(string: "3.8", attributes: userScoreAttributes)
        
        let totalScoreAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: FontSize.body),
            .foregroundColor: Color.Darkgray!
        ]
        
        let totalScoreString = NSAttributedString(string: " / 5.0", attributes: totalScoreAttributes)
        
        let scoreText = NSMutableAttributedString(attributedString: userScoreString)
        scoreText.append(totalScoreString)
        
        label.attributedText = scoreText
        
        return label
    }()
    
    var resultCommentLabel: UILabel = {
        let label = UILabel()
        
        label.text = "😃 훌륭해요!"
        label.font = .systemFont(ofSize: FontSize.caption)
        label.textColor = Color.Main
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        configureChartView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension PronunciationScoreCollectionViewCell {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        let labelStackView = UIStackView(arrangedSubviews: [resultLabel, resultCommentLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.spacing = 0
        
        addSubview(labelStackView)

        labelStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        }
        
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(labelStackView.snp.leading)
        }
    }
    
    func configureChartView() {
        chartView.noDataText = "데이터가 없습니다."
        chartView.noDataFont = .systemFont(ofSize: FontSize.body)
        chartView.noDataTextColor = Color.Main!
        
        chartView.maxAngle = 180
        chartView.rotationAngle = 180
        
        chartView.legend.enabled = false
        
        chartView.isUserInteractionEnabled = false
        
        updateChartData()
    }
    
    func updateChartData() {
        setDataCount(3.8)
    }

    func setDataCount(_ score: Double) {
        let userScoreEntry = PieChartDataEntry(value: score)
        let backgroundEntry = PieChartDataEntry(value: 5.0 - score)
        
        let set = PieChartDataSet(entries: [userScoreEntry, backgroundEntry])
        set.sliceSpace = 0
        set.selectionShift = 5
        set.colors = [Color.Purple!, Color.Background!]
        set.drawValuesEnabled = false
        
        let data = PieChartData(dataSet: set)
        chartView.data = data
        
        chartView.setNeedsDisplay()
    }
}
