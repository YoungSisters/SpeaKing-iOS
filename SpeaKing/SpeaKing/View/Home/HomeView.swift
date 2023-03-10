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
}

class HomeView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.Background
        self.dismissKeyboardWhenTappedAround()
        configureTableView()
        setTableViewDelegate()
    }
    
    var delegate: HomeViewDelegate?
    
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
    
}

extension HomeView: NewSpeakingButtonDelegate {
    func buttonTapped() {
        delegate?.pushNewSpeaking()
    }
}

// MARK: - UITableView
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeSpeakingTableViewCell.cellIdentifier) as! HomeSpeakingTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 + 16
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeHeaderView()
        headerView.newSpeakingButton.delegate = self
        
        let sectionHeaderView = HomeSectionHeaderView()
        
        return section == 0 ? headerView : sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200 : 180
    }
}
