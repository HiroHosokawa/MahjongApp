//
//  GameDataModel.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/04/24.
//

import Foundation
import RealmSwift

// 対局データ.
class GameDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// 日付.
    @objc dynamic var date = Date()
    /// ユーザーネーム.
    var userNames = List<MemberDataModel>()
    /// チップデータ.
    var chipData = List<ChipDataModel>()
    /// スコア.
    var scoreData0 = List<ScoreDataModel>()
    
}

class MemberDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// ユーザー名.
    @objc dynamic var memberName = ""
}

// TODO: 別ファイルとして移動させる
/// ユーザーデータ.
class UserDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// ユーザー名.
    @objc dynamic var userName = ""
}

/// チップデータ.
class ChipDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// チップ.
    @objc dynamic var chip: Int = 0
}

/// スコアデータ.
class ScoreDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// スコア.
    @objc dynamic var score: Int = 0
}

//
//class Member: Object {
//    @objc dynamic  var id: String = ""
//    @objc dynamic  var name: String = ""
//}
//
//class Game: Object {
//    @objc dynamic  var id: String = ""
//    @objc dynamic   var memberIDs: [String] = [] // RealmのListは順番を保持できるため、並び順通りに追加する
//    @objc dynamic   var scores: [Score] = [] // 点数
//    @objc dynamic   var tips: [Tip] = [] // チップ
//    @objc dynamic   var date: Date // 開始(終了)時間
//    @objc dynamic  var isPlaying: Bool // ゲーム中かすでに保存済みか
//}
//
//class Score: Object {
//    @objc dynamic var id: String = ""
//    @objc dynamic var playerID: String = "" // 参加者のIDと紐づく
//    @objc dynamic var points: [Int] = [] // 縦に並ぶ点数を順番通りに保存する
//}
//
//class Tip: Object {
//    @objc dynamic var id: String = ""
//    @objc dynamic var playerID: String = "" // 参加者のIDと紐づく
//    @objc dynamic var value: Int = 0 // 金額(?)
//}
