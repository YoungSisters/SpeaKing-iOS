//
//  CategoryView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

protocol CategoryViewDelegate {
    func newCategoryTapped()
}

class CategoryView: UIView {
    
    private let categories = ["인터뷰 연습", "회화"]
    
    var delegate: CategoryViewDelegate?
    
    var titleView = SPTitleView(title: "새 SpeaKing을 저장할\n카테고리를 선택해주세요.", subtitle: nil)
    
    private var categoryList = [CategoryResult]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = Color.White
        tableView.layer.cornerRadius = 16
        
        return tableView
    }()
    
    lazy var bottomButton: SPBottomButton = {
        let button = SPBottomButton(type: .custom)
        
        button.setTitle("완료", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

// MARK: - Setup
extension CategoryView {
    func style() {
        backgroundColor = Color.Background
        titleView.backgroundColor = Color.Background
    }
    
    func layout() {
        addSubview(bottomButton)

        bottomButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomButton.snp.top).offset(-24)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(tableView.snp.top).offset(-16)
        }
        
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryNewTableViewCell.self, forCellReuseIdentifier: CategoryNewTableViewCell.cellIdentifier)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.cellIdentifier)
        
        tableView.separatorColor = Color.Background
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    }
}

// MARK: - Communicate with view controller
extension CategoryView {
    func setCategoryList(_ list: [CategoryResult]) {
        self.categoryList = list
        self.tableView.reloadData()
    }
}

// MARK: - UITableView
extension CategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryNewTableViewCell.cellIdentifier, for: indexPath) as! CategoryNewTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellIdentifier, for: indexPath) as! CategoryTableViewCell
            
            cell.titleLabel.text = categoryList[indexPath.row - 1].name
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegate?.newCategoryTapped()
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            cell.isSelected.toggle()
            cell.setSelected(cell.isSelected, animated: true)
        }
    }
    
}
