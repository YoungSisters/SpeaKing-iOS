//
//  NewSpeakingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

class NewSpeakingView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    lazy var bottomButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("다음", for: .normal)
        
        return button
    }()
    
    private let section = [SectionModel(title: "SpeaKing 제목", subtitle: nil), SectionModel(title: "카테고리", subtitle: nil), SectionModel(title: "상황 선택", subtitle: "SpeaKing이 상황에 맞는 결과를 분석해드려요.")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dismissKeyboardWhenTappedAround()
        
        style()
        layout()
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}

extension NewSpeakingView {
    func style() {
        backgroundColor = Color.Background
        
    }
    
    func layout() {
        addSubview(bottomButton)
        
        bottomButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
                
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(bottomButton.snp.top).offset(-16)
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionFooterHeight = 0
    }
}

// MARK: - UITableView
extension NewSpeakingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewSpeakingTitleTableViewCell()
        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.section[section]
        let headerView = SPTitleView(title: section.title, subtitle: section.subtitle)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
}
