//
//  Audio.swift
//  SpeaKing
//
//  Created by 이서영 on 2023/05/15.
//

import Foundation
import RealmSwift

class Audio: Object {
    @Persisted var id: String
    @Persisted var url: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, url: String) {
        self.init()
        self.id = id
        self.url = url
    }
}
