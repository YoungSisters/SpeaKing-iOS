//
//  NewSpeakingView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit
import SnapKit

protocol NewSpeakingViewDelegate {
    func categorySelectionTapped()
    func saveInfoAndStartRecording()
}

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
    
    var delegate: NewSpeakingViewDelegate?
    
    private var speakingTitle: String?
    private var formality: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
        configureTableView()
        
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
    @objc func bottomButtonTapped() {
        delegate?.saveInfoAndStartRecording()
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
        tableView.allowsSelection = true
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionFooterHeight = 0
        
        tableView.register(NewSpeakingTitleTableViewCell.self, forCellReuseIdentifier: NewSpeakingTitleTableViewCell.cellIdentifier)
        tableView.register(NewSpeakingCategoryTableViewCell.self, forCellReuseIdentifier: NewSpeakingCategoryTableViewCell.cellIdentifier)
        tableView.register(NewSpeakingFormalityTableViewCell.self, forCellReuseIdentifier: NewSpeakingFormalityTableViewCell.cellIdentifier)
    }
    
    @objc func titleTextChanged(_ sender: SPTextField) {
        speakingTitle = sender.text
        NewSpeakingInfo.shared.title = sender.text
    }
}

// MARK: - UITableView
extension NewSpeakingView: UITableViewDelegate, UITableViewDataSource {
    enum NewSpeakingSection: Int {
        case title = 0
        case category
        case formality
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != 2 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let formality = NewSpeakingInfo.shared.formality, let formalityIndex = Int(formality) {
            if indexPath.section == 2 &&  indexPath.row == formalityIndex {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewSpeakingTitleTableViewCell.cellIdentifier, for: indexPath) as! NewSpeakingTitleTableViewCell
            
            cell.contentView.isUserInteractionEnabled = false
            cell.addTitleTextFieldTarget(self, action: #selector(titleTextChanged))
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewSpeakingCategoryTableViewCell.cellIdentifier, for: indexPath) as! NewSpeakingCategoryTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewSpeakingFormalityTableViewCell.cellIdentifier, for: indexPath) as! NewSpeakingFormalityTableViewCell
            
            let cellText = [["💼", "Formal", "학업, 비즈니스, 시험 등을 위한 말하기예요."], ["🎮", "Informal", "일상적인 말하기예요."]]
            
            cell.formalityView.iconLabel.text = cellText[indexPath.row][0]
            cell.formalityView.titleLabel.text = cellText[indexPath.row][1]
            cell.formalityView.descriptionLabel.text = cellText[indexPath.row][2]
            
            if let formality = NewSpeakingInfo.shared.formality, let formalityIndex = Int(formality) {
                if indexPath.row == formalityIndex {
                    cell.isSelected = true
                    cell.setSelected(true, animated: false)
                }
            }

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            delegate?.categorySelectionTapped()
        } else if indexPath.section == 2 {
            let cell = tableView.cellForRow(at: indexPath) as! NewSpeakingFormalityTableViewCell
            formality = String(indexPath.row)
            NewSpeakingInfo.shared.formality = indexPath.row == 0 ? "Formal" : "Informal"
            cell.isSelected.toggle()
            cell.setSelected(cell.isSelected, animated: false)
        }
    }
    
    // MARK: - Sections
    
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
