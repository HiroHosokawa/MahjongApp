//
//  GameDataModel.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/20.
//

import Foundation
import RealmSwift

//class UserData: Object {
//    @objc dynamic var userName = ""
//}

class MatchData: Object {
@objc dynamic var id: String = ""
//    var members: List<UserData>
     var scoreList: [String] = []
//   var date: Date
}
//
class ScoreData: Object {
//    var id: String = ""
   @objc dynamic var score: String = ""
//    var order: Int = 0
//    var authorID: String = ""
}
//
//class CheckData: Object {
//    var ronCount: Int = 0
//    var tsumoCount: Int = 0
//    var huroCount: Int = 0
//    var hurikomiCount: Int = 0
//    var reachCount: Int = 0
//    var gameCount: Int = 0
//}
