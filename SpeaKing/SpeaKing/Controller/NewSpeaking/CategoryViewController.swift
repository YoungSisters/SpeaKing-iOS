//
//  CategoryViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categoryView = CategoryView()
    
    var categoryService: CategoryServiceProtocol!

    var contentView: CategoryView {
        return view as! CategoryView
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
        setupCategoryView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getCategoryList()
    }
    
    func setupCategoryView() {
        categoryView.delegate = self
        view = categoryView
    }
}

extension CategoryViewController: CategoryViewDelegate {
    func newCategoryTapped() {
        let newCategoryViewController = NewCategoryViewController(categoryService: CategoryService())
        newCategoryViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: newCategoryViewController)
        if #available(iOS 15.0, *) {
            if let sheet = navigationController.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom { _ in 285 } ]
                } else {
                    sheet.detents = [.medium()]
                }
            }
        }
        self.present(navigationController, animated: true)
    }
}

// MARK: - Networking
extension CategoryViewController {
    func getCategoryList() {
        categoryService.getCategoryList { response in
            self.categoryView.setCategoryList(response.result)
        }
    }
}


extension CategoryViewController: NewCategoryViewControllerDelegate {
    func newCategoryViewControllerDidDismiss() {
        self.getCategoryList()
    }
}
