//
//  SPUserDefaults.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/04/03.
//

import Foundation

class SPUserDefaults {
    enum DefaultsKey: String, CaseIterable {
        case nickname
        case email
        case isUserLogin
    }
    
    static let shared = SPUserDefaults()
    private let defaults = UserDefaults.standard

    init() {}
    
    func set(_ value: Any?, key: DefaultsKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    func get(key: DefaultsKey) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
}
