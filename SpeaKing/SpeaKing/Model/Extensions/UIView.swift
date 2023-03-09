//
//  UIView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/10.
//

import Foundation
import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = Color.Main!.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}
