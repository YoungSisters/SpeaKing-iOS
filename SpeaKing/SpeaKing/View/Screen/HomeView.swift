//
//  HomeView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/07.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
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
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableView
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
