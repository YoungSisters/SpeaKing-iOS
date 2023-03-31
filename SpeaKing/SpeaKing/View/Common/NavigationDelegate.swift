//
//  NavigationDelegate.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/31.
//

import Foundation

protocol NavigationDelegate: AnyObject {
    func pushNextViewController()
    
    func navigateBack()
}
