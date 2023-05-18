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

        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNewSpeakingView()
    }
    
    func setupNewSpeakingView() {
        let newSpeakingView = NewSpeakingView()
        newSpeakingView.delegate = self
        view = newSpeakingView
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = Color.Main
        navigationItem.backButtonTitle = ""
        navigationItem.title = "새 SpeaKing"
    }
}

extension NewSpeakingViewController: NewSpeakingViewDelegate {
    func saveInfoAndStartRecording() {
        guard let title = NewSpeakingInfo.shared.title, let category = NewSpeakingInfo.shared.category, let formality = NewSpeakingInfo.shared.formality else {
            assert(false)
            return
        }
        self.navigationController?.pushViewController(RecordingViewController(), animated: true)
    }
    
    func categorySelectionTapped() {
        let categoryViewController = CategoryViewController(categoryService: CategoryService())
        
        self.navigationController?.pushViewController(categoryViewController, animated: true)
    }
}
