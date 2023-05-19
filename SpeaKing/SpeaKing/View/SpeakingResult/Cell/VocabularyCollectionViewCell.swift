//
//  VocabularyCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/23.
//

import UIKit
import Charts

class VocabularyCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "VocabularyCell"
    
    private let values: [Double] = [3, 2, 2, 1, 1]
    private let nameData = ["conference", "man", "white", "picture", "giving"]
    
    var chartView = BarChartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()

        configureChart()
        setChart(dataPoints: nameData, values: values)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        
        // 차트 컬러
        chartDataSet.colors = [Color.Purple!]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        
        // bar 위에 뜨는 값 폰트 설정
        chartData.setValueFont(.systemFont(ofSize: FontSize.caption))
        chartData.setValueTextColor(Color.Main!)
        // bar 너비 조절
        chartData.barWidth = 0.3

        chartView.data = chartData
        
        // 데이터 value 소수점 자릿수 없애기
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        chartView.doubleTapToZoomEnabled = false
        // 범례 숨기기
        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false

        // X축 레이블 위치 조정
        chartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: nameData)
        // X축 라벨 폰트 설정
        chartView.xAxis.labelTextColor = Color.Main!
        chartView.xAxis.labelFont = .systemFont(ofSize: FontSize.caption)
        chartView.xAxis.drawAxisLineEnabled = false
        
        // 세로 grid 없애기
        chartView.xAxis.drawGridLinesEnabled = false
        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        chartView.xAxis.setLabelCount(nameData.count, force: false)
        
        // 왼쪽, 오른쪽 레이블 제거
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        
        // 맥시멈
//        chartView.leftAxis.axisMaximum = 200
        // 미니멈
        chartView.leftAxis.axisMinimum = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension VocabularyCollectionViewCell {
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
    
    func configureChart() {
        chartView.noDataText = "데이터가 없습니다."
        chartView.noDataFont = .systemFont(ofSize: FontSize.body)
        chartView.noDataTextColor = Color.Main!
    }
}
