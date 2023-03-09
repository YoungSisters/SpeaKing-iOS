//
//  ViewController.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/05.
//

import UIKit

class HomeViewController: UIViewController {
    
//    var homeView = HomeView(frame: UIScreen.main.bounds)
    
    var contentView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.addSubview(homeView)
    }


}

