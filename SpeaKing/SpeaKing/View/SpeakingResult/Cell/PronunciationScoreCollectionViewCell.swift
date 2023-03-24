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
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
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
        self.setDataCount(4, range: 100)
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5), label: String(i))
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.sliceSpace = 3
        set.selectionShift = 5
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 11)!)
        data.setValueTextColor(.white)
        
        chartView.data = data
        
        chartView.setNeedsDisplay()
    }
}
