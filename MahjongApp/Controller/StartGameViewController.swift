
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.

import Foundation
import UIKit
import RealmSwift
import SwiftUI

// ゲームデータに関連するCellのセクションタイプ.
// TODO: 最終的にはファイル移動する
enum GameScoreType: Int {
    /// チップ.
    case chip = 0
    /// スコア.
    case score = 1
}

protocol GameDataViewControllerDelegate: AnyObject {
    func selectUserViewController( index: IndexPath)
}
class StartGameViewController: UIViewController {
    
    weak var delegate: GameDataViewControllerDelegate?
    var histryDataModel: GameDataModel?
    var index: IndexPath?
    var test = true
    var test2 = false
    var sampleMember: [String] = ["未入力","未入力","未入力","未入力"]
    //対局者のデータ
    var matchMember = [UserMasterDataModel](repeating: .init(), count: 4)
    //セクションタイトル
    var collectionViewSection: [String] = ["対局メンバー"]
    var collectionViewSection2: [String] = ["チップ入力欄","スコア入力欄"]
    var collectionViewSection3: [String] = ["合計"]
    /// 合計値のデータ.
    var totalData = [Int](repeating: 0, count: 4)
    /// チップのデータ.
    var chipData = [ChipDataModel](repeating: .init(), count: 4)
    /// スコアのデータ.
    var scoreData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 30)
    //対局者毎のスコア
    private var memberScore = [[Int]](repeating: [Int](repeating: .init(), count: 30), count: 4)
    //対局者毎のチップ
    var memberChipData = [Int](repeating: .init(), count: 4)
    //対局者の順位づけに必要なデータ
    private var rankData = [[Int]](repeating: [Int](repeating: .init(), count: 4), count: 30)
    //ツールバー
    var toolBar: UIToolbar {
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        let toolBar = UIToolbar(frame: toolBarRect)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTupDone))
        toolBar.setItems([doneItem], animated: true)
        return toolBar
    }
    
    @objc func didTupDone() {
        view.endEditing(true)
    }
    
    let startGameCollectionViewCell2 = StartGameCollectionViewCell2()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBarButtonのセットする
        setNavigationBarButton()
        // CollectionViewをセットする
        setCollectionViews()
        self.title = "対局"
        //閲覧用のデータをセットする
        setViewData2()
    }
    
    //閲覧用のデータを表示
    func setViewData2() {
        guard let data = histryDataModel else {
            return
        }
        collectionView2.reloadData()
        //メンバーをセット
        self.matchMember = data.userNames.compactMap({ $0.convert(data: $0)
        })
        self.totalData = data.totalScoreData.compactMap({ $0.score
        })
        self.chipData = data.chipData.compactMap({ $0
        })
        self.scoreData = test(data: data)
        
        //日付を表示
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let date = dateFormatter.string(from: data.date)
        self.title = "\(date)"
    }
    
    func test(data: GameDataModel) -> [[ScoreDataModel]] {
        var score = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 30)
        
        data.scoreData.enumerated().forEach { index, data in
            let row = index / 4
            let columm = index % 4
            score[row][columm] = data
            
        }
        return score
    }
    
    //リセット機能の実装
    func resetData() {
        //        let startGameCollectionViewCell = StartGameCollectionViewCell()
        self.matchMember = [UserMasterDataModel](repeating: .init(), count: 4)
        self.scoreData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 30)
        self.chipData = [ChipDataModel](repeating: .init(), count: 4)
        self.totalData = [Int](repeating: 0, count: 4)
        // UICollectionViewをリロードする
        self.collectionView3.reloadData()
        self.collectionView2.reloadData()
        self.collectionView.reloadData()
        //            startGameCollectionViewCell.deletText()
    }
    
    //初期化
    init() {
        super.init(nibName: String(describing: StartGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // NavigationBarButtonのセットする.
    func setNavigationBarButton() {
        if test2 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(didTapBackButton))
        }else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(didTapSaveButton))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "リセット", style: .plain, target: self, action: #selector(didTapResetButton))
        }
    }
    //    colectionViewをセット
    func setCollectionViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView3.dataSource = self
        collectionView3.delegate = self
        let nib = UINib(nibName: "StartGameCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
        let nib2 = UINib(nibName: "StartGameCollectionViewCell2", bundle: nil)
        collectionView2!.register(nib2, forCellWithReuseIdentifier: "Cell2")
        let nib4 = UINib(nibName: "StartGameCollectionViewCell3", bundle: nil)
        collectionView3!.register(nib4, forCellWithReuseIdentifier: "Cell3")
        let nib3 = UINib(nibName: "TestCollectionReusableView", bundle: nil)
        collectionView!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView2!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView3!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
    
    //    未入力スコアがあるかチェック
    func checkScore()-> Bool {
        
        let nonNilCount = scoreData.reduce(0) { count, row in
            return count + row.compactMap { $0.score }.count
        }
        return nonNilCount % 4 != 0
    }
    //    重複するメンバーがいるかチェック
    func hasDuplicates() -> Bool {
        let stringArray = matchMember.map { $0.userName }
        
        let set = Set(stringArray)
        return set.count != stringArray.count
        
    }
    
    // todo リファクタリング可能　for in　文以外で
    //    未入力の対局者がいるかチェック
    func checkMemberData() -> Bool {
        for i in 1 ... matchMember.count {
            if matchMember[i - 1].userName == "" {
                return true
            }       }
        return false
    }
    
    // ダイアログの保存Button処理.
    @objc func didTapSaveButton(_ sender: UIBarButtonItem) {
        //    TODO　タイトルが未入力の場合のアラート文を作成する
        if checkMemberData()
        {
            let alert = UIAlertController(
                title: "入力不備があります",
                message: "対局者を決定してください。",
                preferredStyle: .alert)
            
            let ok = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) -> Void in
                })
            alert.addAction(ok);
            self.present(alert, animated: true, completion: nil)
            
        }
        else if checkScore() {
            let alert = UIAlertController(
                title: "入力不備があります",
                message: "未入力のスコアがないか確認してください。",
                preferredStyle: .alert)
            
            let ok = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) -> Void in
                })
            alert.addAction(ok);
            self.present(alert, animated: true, completion: nil)
            
        } else if hasDuplicates() {
            let alert = UIAlertController(
                title: "入力不備があります",
                message: "同じ名前は追加できません。。",
                preferredStyle: .alert)
            
            let ok = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) -> Void in
                })
            alert.addAction(ok);
            self.present(alert, animated: true, completion: nil)
        }else {
            
            let alert = UIAlertController(
                title: "対局の終了",
                message: "対局を保存して終了します。よろしいですか？",
                preferredStyle: .alert)
            
            let add = UIAlertAction(
                title: "保存",
                style: .default,
                handler: { [self] (action) -> Void in
                    // self.saveMemberScoreData()
                    self.saveRecord()
                    self.saveTestData()
                    self.resetData()
                    let vc = GameDataViewController()
                    navigationController?.pushViewController(vc, animated: true)
                })
            
            let cancel = UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: { (action) -> Void in
                    print("Cancel button tapped")
                })
            
            alert.addAction(add);
            alert.addAction(cancel);
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //ダイアログの戻るボタン処理
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // ダイアログのキャンセルButton処理.
    @objc func didTapResetButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "データの消去",
            message: "現在のページを白紙に戻します。よろしいですか？",
            preferredStyle: .alert)
        
        let add = UIAlertAction(
            title: "リセット",
            style: .default,
            handler: { (action) -> Void in
                self.resetData()
            })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        alert.addAction(add);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
    }
}

extension StartGameViewController {
    // 対局の情報を保存する.
    func saveRecord() {
        // 初期化
        let realm = try! Realm()
        // scoreDataModel
        var scoreDataModel: [ScoreDataModel]  = []
        // MemberDataModel
        var userNames: [MemberDataModel] = []
        // トータルスコアデータ
        var totalScoreData: [ScoreDataModel]  = []
        
        for row in scoreData {
            for test in row {
                scoreDataModel.append(test)
            }
        }
        //対局数のカウント
        let testData = scoreDataModel
        let data = testData.filter { $0.score != nil }
        let count = data.count / 4
        
        // トータルスコアデータ
        totalData.forEach { score in
            let scoreDataModel = ScoreDataModel()
            scoreDataModel.score = score
            totalScoreData.append(scoreDataModel)
        }
        
        // マスターデータからmemberDataを作成
        matchMember.forEach { data in
            let memberData = MemberDataModel()
            memberData.id = data.id
            memberData.memberName = data.userName
            userNames.append(memberData)
        }
        
        // realmを書き換え
        try! realm.write {
            // GameDataModel
            let record = GameDataModel()
            record.date = Date()
            // スコア
            record.scoreData.append(objectsIn: scoreDataModel)
            // チップ
            record.chipData.append(objectsIn: chipData)
            // ユーザーネーム
            record.userNames.append(objectsIn: userNames)
            // 対局数
            record.gamecount = count
            // トータルデータ
            record.totalScoreData.append(objectsIn: totalScoreData)
            realm.add(record)
        }
    }
    
    //    UserMasterDataModelのrealm保存
    private func saveTestData() {
        let realm = try! Realm()
        var testData = [[Int]]()
        //  スコアを順位に変換
        for row in rankData {
            let scores = row.map { $0 }
            let sortedScores = scores.sorted(by: { $0 > $1 })
            let ranks = scores.map { score in
                sortedScores.firstIndex(of: score)! + 1
            }
            testData.append(ranks)
        }
        //空欄の配列を削除
        let filteredData = testData.filter { array in
            !array.allSatisfy { $0 == 1 }
        }
        
        var test2Data: [Int] = []
        //各列毎の順位に並び替え
        for row in filteredData {
            for test in row {
                test2Data.append(test)
            }
        }
        //対局者毎のスコアに並び替え
        var memberRankData = [[Int]](repeating: [Int](repeating: 0, count: test2Data.count / 4), count: 4)
        
        for (index, score) in test2Data.enumerated() {
            let row = index % 4
            let column = index / 4
            memberRankData[row][column] = score
        }
        // 対局データを保存
            matchMember.enumerated().forEach { index, data in
                guard let targetEmployee = realm.objects(UserMasterDataModel.self).filter({ $0.id == data.id }).first else {
                    return
                }

                // ユーザーマスタースコアが存在する場合に更新、なければ新規作成
                if let userMasterScoreDataModel = targetEmployee.userMasterScore {
                    try! realm.write {
                        // 既存のデータを更新する
                        userMasterScoreDataModel.matchCount += memberRankData[0].count
                        userMasterScoreDataModel.score += memberScore[index].reduce(0, +)
                        userMasterScoreDataModel.chip += memberChipData[index]
                        userMasterScoreDataModel.total += totalData[index]

                        let memberRank = memberRankData[index]
                        for rank in memberRank {
                            switch rank {
                            case 1:
                                userMasterScoreDataModel.rank?.firstPlace += 1
                            case 2:
                                userMasterScoreDataModel.rank?.secondPlace += 1
                            case 3:
                                userMasterScoreDataModel.rank?.thirdPlace += 1
                            case 4:
                                userMasterScoreDataModel.rank?.forthPlace += 1
                            default:
                                print("Error: Invalid rank")
                            }
                        }
                    }
                } else {
                    try! realm.write {
                        // ユーザーマスタースコアがない場合に新規作成する
                        let userMasterScoreDataModel = UserMasterScoreDataModel()
                        userMasterScoreDataModel.matchCount = memberRankData[0].count
                        userMasterScoreDataModel.score = memberScore[index].reduce(0, +)
                        userMasterScoreDataModel.chip = memberChipData[index]
                        userMasterScoreDataModel.total = totalData[index]

                        let userMasterRankDataModel = UserMasterRankDataModel()
                        let memberRank = memberRankData[index]
                        for rank in memberRank {
                            switch rank {
                            case 1:
                                userMasterRankDataModel.firstPlace += 1
                            case 2:
                                userMasterRankDataModel.secondPlace += 1
                            case 3:
                                userMasterRankDataModel.thirdPlace += 1
                            case 4:
                                userMasterRankDataModel.forthPlace += 1
                            default:
                                print("Error: Invalid rank")
                            }
                        }
                        userMasterScoreDataModel.rank = userMasterRankDataModel
                        targetEmployee.userMasterScore = userMasterScoreDataModel
                        realm.add(targetEmployee)
                    }
                }
            }
        }
}

/// 各チップもしくはスコアの入力が終わると呼ばれる.
extension StartGameViewController: StartGamerViewControllerCell2Delegate {
    /// ゲームスコアをセットする
    func setGameScore(
        score: Int,
        index: Int,
        gameScoreType: GameScoreType
    ) {
        switch gameScoreType {
        case .chip:
            let addChipData = ChipDataModel()
            addChipData.chip = score
            chipData[index] = addChipData
            memberChipData[index] = score
            
        case .score:
            let rowIndex = index / 4
            let columnIndex = index % 4
            let addScoreData = ScoreDataModel()
            addScoreData.score = score
            scoreData[rowIndex][columnIndex] = addScoreData
            memberScore[columnIndex][rowIndex] = score
            rankData[rowIndex][columnIndex] = score
            // 行毎の数字を自動入力する実装
            handleMissingScore(index: index)
            //           checkTest(index: index)
        }
        // ゲームスコアの計算をする
        gameScoreCalculation(index: index)
        // collectionViewのreload
        collectionView2.reloadData()
        collectionView3.reloadData()
    }
    
    // 行毎の数字を自動入力する実装
    func handleMissingScore(index: Int) {
        let score = scoreData[index / 4]
        let nilIndices = score.filter { $0.score == nil }
        
        if nilIndices.count == 1 {
            if let firstIndex = score.firstIndex(where: { $0.score == nil }) {
                let addScoreData = ScoreDataModel()
                addScoreData.score = calculateNegativeScore(forIndex: index)
                scoreData[index / 4][firstIndex % 4] = addScoreData
            }
        }
    }
    
    /// 点数を自動計算をする
    private func calculateNegativeScore(forIndex index: Int) -> Int {
        var negativeScore = 0
        
        scoreData[index / 4].forEach { data in
            negativeScore -= data.score ?? 0
        }
        
        return negativeScore
    }
    
    /// ゲームスコアの計算をする
    private func gameScoreCalculation(index: Int) {
        /// Aさん.
        var a = 0
        /// Bさん.
        var b = 0
        /// Cさん.
        var c = 0
        /// Dさん.
        var d = 0
        //        /// Eさん.
        //        var e = 0
        
        // TODO: ここのロジックはリファクタリングできる(優先度: 中)
        
        for row in scoreData {
            for(columnIndex,score) in row.enumerated() {
                switch columnIndex {
                case 0:
                    // A列の合計を計算する(左から1番目)
                    a += score.score ?? 0
                    totalData[0] = a
                case 1:
                    // B列の合計を計算する(左から2番目)
                    b += score.score ?? 0
                    totalData[1] = b
                case 2:
                    // C列の合計を計算する(左から3番目)
                    c += score.score ?? 0
                    totalData[2] = c
                case 3:
                    // D列の合計を計算する(左から4番目)
                    d += score.score ?? 0
                    totalData[3] = d
                    //            case 4:
                    //                // E列の合計を計算する(左から5番目)
                    //                e += element.score
                    //                totalData[4] = e
                    //
                default:
                    break
                }
            }
        }
        for(index,_) in chipData.enumerated() {
            switch index {
            case 0:
                // A列のチップを計算する(左から1番目)
                a += chipData[0].chip ?? 0
                totalData[0] = a
                
            case 1:
                // B列のチップを計算する(左から2番目)
                b += chipData[1].chip ?? 0
                totalData[1] = b
                
            case 2:
                // C列のチップを計算する(左から3番目)
                c += chipData[2].chip ?? 0
                totalData[2] = c
                
            case 3:
                // D列のチップを計算する(左から4番目)
                d += chipData[3].chip ?? 0
                totalData[3] = d
                
                //            case 4:
                //                // E列のチップを計算する(左から5番目)
                //                e += chipData[4].chip
                //                totalData[4] = e
                
            default:
                break
            }
        }
    }
}

extension StartGameViewController: UICollectionViewDelegate {
    //    colectionView毎のセクション数を設定
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag == 0 {
            return collectionViewSection.count
        }else if collectionView.tag == 1 {
            return collectionViewSection2.count
        }else if collectionView.tag == 2 {
            return collectionViewSection3.count
        } else {
            return 1
        }
    }
}

extension StartGameViewController: UICollectionViewDataSource {
    //    セクション毎にセルの個数を設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return matchMember.count
        }else if collectionView.tag == 1 {
            switch(section){
            case 0:
                return chipData.count
            case 1:
                return matchMember.count * 30
            default:
                print("error")
                return 0
            }
        }else if collectionView.tag == 2 {
            return totalData.count
        }else{
            return 2
        }
    }
    
    //    カスタムセルの内容を表示する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
            cell.setborderColor()
            let username = matchMember[indexPath.row].userName
            /// usernemeが空文字のときはサンプルメンバーを使う.
            cell.setText(username.isEmpty ? sampleMember[indexPath.row] : username )
            return cell
            
        } else if collectionView.tag == 2 {
            let cell = collectionView3.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! StartGameCollectionViewCell3
            cell.deletText()
            cell.setborderColor2()
            // cell.editLabel2()
            cell.setText2(String(totalData[indexPath.row]))
            cell.setTextColor()
            
            return cell
        } else {
            let cell = collectionView2.dequeueReusableCell(
                withReuseIdentifier: "Cell2",
                for: indexPath
            ) as! StartGameCollectionViewCell2
            
            cell.inputScore.inputAccessoryView = toolBar
            cell.delegate = self
            cell.deletText()
            if let gameScoreType = GameScoreType(rawValue: indexPath.section) {
                cell.setUp(index: indexPath.row, gameScoreType: gameScoreType, label: convertScore(type: gameScoreType, index: indexPath.row), check: test
                           
                )
            }
            return cell
        }
    }
    
    //    対局者を決定
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 && indexPath.section == 0 && self.test  {
            let vc = SelectUserViewController()
            vc.index = indexPath
            vc.delegate = self
            //            print(indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }else {
        }
    }
    //  セクションのタイトルを設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
        
        if collectionView.tag == 0 {
            header.sectionLabel.text = collectionViewSection[indexPath.section]
        } else if collectionView.tag == 1 {
            header.sectionLabel.text = collectionViewSection2[indexPath.section]
        } else if collectionView.tag == 2 {
            header.sectionLabel.text = collectionViewSection3[indexPath.section]
        }
        
        return header
    }
}

extension StartGameViewController: UICollectionViewDelegateFlowLayout {
    //    セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let width: CGFloat = UIScreen.main.bounds.width / CGFloat(matchMember.count)
            let height: CGFloat = UIScreen.main.bounds.height / 15
            return CGSize(width: width, height: height)
        }else if collectionView.tag == 1 {
            let width: CGFloat = UIScreen.main.bounds.width / CGFloat(matchMember.count)
            let height: CGFloat = UIScreen.main.bounds.height / 15
            return CGSize(width: width, height: height)
        }else {
            let width: CGFloat = UIScreen.main.bounds.width / CGFloat(totalData.count)
            let height: CGFloat = UIScreen.main.bounds.height / 15
            return CGSize(width: width, height: height)
        }
    }
    //    セル列の余白の間隔調整
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    //セル行間の余白を調整
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    //セクション名とサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 30)
    }
}

extension StartGameViewController: SelectUserViewControllerDelegate  {
    func selectUserViewController(user: UserMasterDataModel, index: IndexPath) {
        if collectionView.tag == 0 {
            matchMember[index.row] = user
            collectionView.reloadData()
        }
    }
}

extension StartGameViewController {
    /// スコアデータをコンバートする
    func convertScore(type: GameScoreType ,index: Int) -> String {
        // タイプによって使うデータを分ける
        let score = type == .score ? scoreData[index / 4][index % 4].score : chipData[index].chip
        // スコアがnilではないのならその値を返す
        if let scoreString = score {
            return String(scoreString)
        }
        return ""
    }
}
