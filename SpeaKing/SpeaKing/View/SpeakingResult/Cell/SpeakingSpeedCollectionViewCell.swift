//
//  SpeakingSpeedCollectionViewCell.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/19.
//

import UIKit
import Charts

class SpeakingSpeedCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "SpeakingSpeedCell"
    
    private var standardSpeed = 0.0
    private var userSpeed = 0.0
    private var values = [125.0, 127.0]
    private var nameData = ["기준", "User"]
    
    var barChartView = HorizontalBarChartView()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        
        label.text = "딱 좋아요!"
        label.font = .systemFont(ofSize: FontSize.subhead)
        label.textAlignment = .center
        label.textColor = Color.Main
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()

        configureChart()
        setChart(values: [standardSpeed, userSpeed])
    }
    
    func setChart(values: [Double]) {
        
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<2 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        
        // 차트 컬러
        chartDataSet.colors = [Color.Gray!, Color.Purple!]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        
        // bar 위에 뜨는 값 폰트 설정
        chartData.setValueFont(.systemFont(ofSize: FontSize.caption))
        chartData.setValueTextColor(Color.Main!)
        // bar 너비 조절
        chartData.barWidth = 0.7

        barChartView.data = chartData
        
        // 데이터 value 소수점 자릿수 없애기
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        barChartView.doubleTapToZoomEnabled = false
        // 범례 숨기기
        barChartView.legend.enabled = false
        barChartView.isUserInteractionEnabled = false

        // X축 레이블 위치 조정
        barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: nameData)
        // X축 라벨 폰트 설정
        barChartView.xAxis.labelTextColor = Color.Main!
        barChartView.xAxis.labelFont = .systemFont(ofSize: FontSize.caption)
        
        // 세로 grid 없애기
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        barChartView.xAxis.setLabelCount(nameData.count, force: false)
        
        // 왼쪽, 오른쪽 레이블 제거
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        
        // 맥시멈
//        barChartView.leftAxis.axisMaximum = 200
        // 미니멈
        barChartView.leftAxis.axisMinimum = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

// MARK: - Setup

extension SpeakingSpeedCollectionViewCell {
    func style() {
        self.backgroundColor = Color.White
        self.layer.cornerRadius = 16
        self.addShadow()
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [barChartView, commentLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configureChart() {
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: FontSize.body)
        barChartView.noDataTextColor = Color.Main!
        
        if let nickname = UserDefaultsManager.getData(type: String.self, forKey: .nickname) {
            nameData[1] = nickname
        }
    }
    
    func setSpeakingSpeed(speed value: String) {
        guard let speed = Double(value) else {
            assert(false)
            return
        }
        
        self.userSpeed = speed
        // TODO: 상황 따른 기준 속도 설정..
        
        setChart(values: [standardSpeed, userSpeed])
        
    }
}
