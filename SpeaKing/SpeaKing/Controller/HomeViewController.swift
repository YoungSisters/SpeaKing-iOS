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
        
        configureNavigationBar()
        profileService.getUserProfile {
            self.homeView.setUserNickname()
        }
        getSpeakingList()
    }
    
    func setupHomeView() {
        homeView.delegate = self
        view = homeView
    }
    
    func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        
        let logoImageView = UIImageView(image: UIImage(named: Image.logo))
        logoImageView.setImageColor(color: Color.Main!)
        logoImageView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageView)
        
    }
}

// MARK: - Networking

extension HomeViewController {
    func getSpeakingList() {
        SpeakingListService.getSpeakingList(nil, nil) { result in
            self.homeView.setSpeakingList(list: result)
        }
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    func pushNewSpeaking() {
        self.navigationController?.pushViewController(NewSpeakingViewController(), animated: true)
    }
}
