//
//  ViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/05.
//

import UIKit

class HomeViewController: UIViewController {
    var contentView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupHomeView() {
        let homeView = HomeView()
        homeView.delegate = self
        view = homeView
    }
}

extension HomeViewController: HomeViewDelegate {
    func pushNewSpeaking() {
        self.navigationController?.pushViewController(NewSpeakingViewController(), animated: true)
    }
}
