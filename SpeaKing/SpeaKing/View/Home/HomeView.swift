//
//  HomeView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/07.
//

import UIKit
import SnapKit

protocol HomeViewDelegate {
    func pushNewSpeaking()
    func pushSpeakingResult(speakingID: Int)
}

class HomeView: UIView {
    
    private var speakingList = [SpeakingListResultModel]()

    var delegate: HomeViewDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.Background
        configureTableView()
        setTableViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        tableView.register(HomeSpeakingTableViewCell.self, forCellReuseIdentifier: HomeSpeakingTableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
    func setUserNickname() {
        self.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
    }
    
    func setSpeakingList(list: [SpeakingListResultModel]) {
        self.speakingList = list
        self.tableView.reloadData()
    }
    
}

extension HomeView: NewSpeakingButtonDelegate {
    func buttonTapped() {
        delegate?.pushNewSpeaking()
    }
}

// MARK: - UITableView

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : speakingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeSpeakingTableViewCell.cellIdentifier) as! HomeSpeakingTableViewCell
                
        cell.setSpeakingData(data: speakingList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 + 16
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 상단 헤더
        let headerView = HomeHeaderView()
        headerView.newSpeakingButton.delegate = self
        
        // 스피킹 목록
        let sectionHeaderView = HomeSectionHeaderView()
        sectionHeaderView.setMySpeakingCountLabel(count: speakingList.count)
        
        return section == 0 ? headerView : sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200 : 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let speakingID = speakingList[indexPath.row].speakingId
        delegate?.pushSpeakingResult(speakingID: speakingID)
    }
}
