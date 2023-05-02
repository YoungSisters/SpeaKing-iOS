//
//  NewCategoryViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/16.
//

import UIKit

protocol NewCategoryViewControllerDelegate {
    func newCategoryViewControllerDidDismiss()
}

class NewCategoryViewController: UIViewController {
    
    var categoryService: CategoryServiceProtocol!
    
    var delegate: NewCategoryViewControllerDelegate!
    
    var contentView: NewCategoryView {
        return view as! NewCategoryView
    }
    
    init(categoryService: CategoryServiceProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.categoryService = categoryService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    func createNewCategory(categoryName name: String) {
        categoryService.postNewCategory(name) {
            self.dismiss(animated: true) {
                self.delegate.newCategoryViewControllerDidDismiss()
            }
        }
    }
}
