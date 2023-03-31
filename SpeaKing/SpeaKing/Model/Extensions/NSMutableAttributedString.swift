//
//  NSMutableAttributedString.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/03/09.
//

import UIKit

extension NSMutableAttributedString {
    func title(string: String) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: FontSize.title)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: "\(string)\n", attributes: attributes))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        self.addAttribute(.paragraphStyle,
                          value: style,
                          range: NSRange(location: 0, length: self.length))
        
        return self
    }
    
    func subtitle(string: String) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: FontSize.body)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
