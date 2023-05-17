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
        label.text = "3.8 / 5.0"
        label.font = .boldSystemFont(ofSize: FontSize.title3)
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
        let stackView = UIStackView(arrangedSubviews: [chartView, resultLabel])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(32)
        }
//        addSubview(resultLabel)
//
//        resultLabel.snp.makeConstraints { make in
//            <#code#>
//        }
//        addSubview(chartView)
//
//        chartView.snp.makeConstraints { make in
////            make.edges.equalToSuperview().inset(16)
//            make.leading.top.bottom.equalToSuperview().inset(16)
//
//        }
    }
    
    func configureChartView() {
        chartView.noDataText = "데이터가 없습니다."
        chartView.noDataFont = .systemFont(ofSize: FontSize.body)
        chartView.noDataTextColor = Color.Main!
        
        chartView.maxAngle = 180
        chartView.rotationAngle = 180
        
        chartView.legend.enabled = false
        
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
