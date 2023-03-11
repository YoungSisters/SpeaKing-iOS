//
//  UITextField.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/11.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
