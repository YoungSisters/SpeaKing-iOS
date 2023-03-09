//
//  UIImageView.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/10.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
}
