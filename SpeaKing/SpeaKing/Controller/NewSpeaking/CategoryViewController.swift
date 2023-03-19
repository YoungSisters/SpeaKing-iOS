//
//  CategoryViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class CategoryViewController: UIViewController {

    var contentView: CategoryView {
        return view as! CategoryView
    }
    
    override func loadView() {
        super.loadView()
        setupCategoryView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupCategoryView() {
        let categoryView = CategoryView()
        categoryView.delegate = self
        view = categoryView
    }
}

extension CategoryViewController: CategoryViewDelegate {
    func newCategoryTapped() {
        let newCategoryViewController = NewCategoryViewController()
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
