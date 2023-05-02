//
//  NewSpeakingViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/14.
//

import UIKit

class NewSpeakingViewController: UIViewController {
    
    var contentView: NewSpeakingView {
        return view as! NewSpeakingView
    }
    
    override func loadView() {
        super.loadView()
        setupNewSpeakingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupNewSpeakingView() {
        let newSpeakingView = NewSpeakingView()
        newSpeakingView.delegate = self
        view = newSpeakingView
    }
}

extension NewSpeakingViewController: NewSpeakingViewDelegate {
    func categorySelectionTapped() {
        let categoryViewController = CategoryViewController(categoryService: CategoryService())
        
        self.navigationController?.pushViewController(categoryViewController, animated: true)
    }
}
