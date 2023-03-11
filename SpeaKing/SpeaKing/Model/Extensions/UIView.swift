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
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
        UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(false)
    }
}
