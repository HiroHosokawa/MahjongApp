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
    
    @objc dynamic var gamecount = Int()
    /// ユーザーネーム.
    var userNames = List<MemberDataModel>()
    /// チップデータ.
    var chipData = List<ChipDataModel>()
    /// スコア.
    var scoreData = List<ScoreDataModel>()
    //トータルスコア
    var totalScoreData = List<ScoreDataModel>()
    
//    var memberScoreData = List<ScoreDataModel>()
    
}

class MemberDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// ユーザー名.
    @objc dynamic var memberName = ""
    
    func convert(data: MemberDataModel) -> UserMasterDataModel {
        let userMasterData = UserMasterDataModel()
        userMasterData.id = data.id
        userMasterData.userName = data.memberName
        return userMasterData
    }
}

/// チップデータ.
class ChipDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// チップ.
    @Persisted var chip: Int?
}

/// スコアデータ.
class ScoreDataModel: Object {
    /// id.
    @objc dynamic var id = UUID()
    /// スコア.
    @Persisted var score: Int? 
}
