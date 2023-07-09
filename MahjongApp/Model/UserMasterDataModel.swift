//
//  GameDataModel.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/06/29.
//

import Foundation
import RealmSwift

/// ユーザーデータ.
class UserMasterDataModel: Object {
    /// id.
    @Persisted var id = UUID()
    /// 日付.
    @objc dynamic var date = Date()
    /// ユーザー名.
    @Persisted var userName = ""
    /// ユーザーマスタスコア
    @Persisted var userMasterScore: UserMasterScoreDataModel?
}

class UserMasterScoreDataModel: Object {
    /// 対戦回数
    @Persisted var matchCount: Int = 0
    /// スコア.
    @Persisted var score: Int = 0
    /// チップ.
    @Persisted var chip: Int = 0
    /// ランク.
    @Persisted var rank: UserMasterRankDataModel?
}

class UserMasterRankDataModel : Object {
    /// 1位.
    @Persisted var firstPlace: Int = 0
    /// 2位.
    @Persisted var secondPlace: Int = 0
    /// 3位.
    @Persisted var thirdPlace: Int = 0
    /// 4位.
    @Persisted var forthPlace: Int = 0
}
