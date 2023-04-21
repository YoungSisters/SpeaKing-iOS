//
//  ViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/05.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var profileService: ProfileServiceProtocol!
    
    private var homeView = HomeView()
    
    var contentView: HomeView {
        return view as! HomeView
    }
    
    init(profileService: ProfileServiceProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.profileService = profileService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileService.getUserProfile {
            self.homeView.setUserNickname()
        }
    }
    
    func setupHomeView() {
        homeView.delegate = self
        view = homeView
    }
}

extension HomeViewController: HomeViewDelegate {
    func pushNewSpeaking() {
        self.navigationController?.pushViewController(NewSpeakingViewController(), animated: true)
    }
}
