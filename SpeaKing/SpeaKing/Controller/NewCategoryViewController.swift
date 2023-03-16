//
//  NewCategoryViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/16.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    var contentView: NewCategoryView {
        return view as! NewCategoryView
    }
    
    override func loadView() {
        super.loadView()
        setupNewCategoryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func setupNewCategoryView() {
        let newCategoryView = NewCategoryView()
        newCategoryView.delegate = self
        
        view = newCategoryView
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "새 카테고리 만들기"
    }
}

extension NewCategoryViewController: NewCategoryViewDelegate {
    func dismissNewCategoryView() {
        self.dismiss(animated: true)
    }
}
