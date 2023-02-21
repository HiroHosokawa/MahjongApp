//
//  GameDataModel.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/20.
//

import Foundation
import RealmSwift

class UserData: Object {
    @objc dynamic var userName = ""
}

class Match: Object {
    
}

class Score: Object {
    
}

class CheckData: Object {
    var ronCount: Int = 0
    var tsumoCount: Int = 0
    var huroCount: Int = 0
    var hurikomiCount: Int = 0
    var reachCount: Int = 0
    var gameCount: Int = 0
}
