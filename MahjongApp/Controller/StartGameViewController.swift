
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.

import Foundation
import UIKit
import RealmSwift

// ゲームデータに関連するCellのセクションタイプ.
// TODO: 最終的にはファイル移動する
enum GameScoreType: Int {
    /// チップ.
    case chip = 0
    /// スコア.
    case score = 1
}

enum LabelType: Int {
    //対局者
    case member = 0
    //合計値
    case sumScore = 1
}

class StartGameViewController: UIViewController {
    var sampleMember: [String] = ["未入力","未入力","未入力","未入力"]
    //対局者のデータ
    var matchMember = [MemberDataModel](repeating: .init(), count: 4)
    var collectionViewSection: [String] = ["対局メンバー"]
    var collectionViewSection2: [String] = ["チップ入力欄","スコア入力欄"]
    var collectionViewSection3: [String] = ["合計"]
    /// 合計値のデータ.
    var totalData = [Int](repeating: 0, count: 4)
    /// チップのデータ.
    private var chipData = [ChipDataModel](repeating: .init(), count: 4)
    /// スコアのデータ.
    var scoreData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 10)
    //対局者毎のスコア
    private var memberScore = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 10), count: 4)
    //対局者の順位づけに必要なデータ
    private var rankData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 10)
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
        self.title = "日付入力"
        // **テスト**
        // Realmデータに保存されているかチェックする(後で削除する)
        checkTestSavedScoreData()
    }
    //リセット機能の実装
    func resetData() {
        self.matchMember = [MemberDataModel](repeating: .init(), count: 4)
        self.scoreData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 10)
        self.chipData = [ChipDataModel](repeating: .init(), count: 4)
        // UICollectionViewをリロードする
        self.collectionView3.reloadData()
        self.collectionView2.reloadData()
        self.collectionView.reloadData()
    }
    
    // Realmデータに保存されているかチェックする(後で削除する).
    // 一番左のスコア入力欄の数字をPrint出力する.
    func checkTestSavedScoreData() {
        let realm = try! Realm()
        var data: [GameDataModel] = []
        let result = realm.objects(GameDataModel.self)
        
        data = Array(result)
        
        if !data.isEmpty {
            print(data[0].scoreData0[0].score, "テストです")
        }
    }
    
    init() {
        super.init(nibName: String(describing: StartGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // NavigationBarButtonのセットする.
    func setNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "リセット", style: .plain, target: self, action: #selector(didTapResetButton))
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
    
    //    func checkScore()-> Bool {
    //        var sum = 0
    //        for i in 1 ... scoreData.count + 1 {
    //            if scoreData[i - 1] != "" {
    //            sum = sum + 1
    //            }
    //        }
    //        return sum % 4 == 0
    //    }
    
    // todo リファクタリング可能　for in　文以外で
    func checkMemberData() -> Bool {
        //        for i in 1 ... matchMember.count {
        //            if matchMember[i - 1].memberName == "" {
        //                return true
        //            }       }
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
        //        else if checkScore() {
        //            let alert = UIAlertController(
        //                title: "入力不備があります",
        //                message: "スコアが正しく入力されてるか確認してください。",
        //                preferredStyle: .alert)
        //
        //            let ok = UIAlertAction(
        //                title: "OK",
        //                style: .default,
        //            handler: { (action) -> Void in
        //            })
        //            alert.addAction(ok);
        //            self.present(alert, animated: true, completion: nil)
        //
        //        }
        else {
            
            let alert = UIAlertController(
                title: "対局の終了",
                message: "対局を保存して終了します。よろしいですか？",
                preferredStyle: .alert)
            
            let add = UIAlertAction(
                title: "保存",
                style: .default,
                handler: { [self] (action) -> Void in
                    let vc = GameDataViewController()
                    // self.saveMemberScoreData()
                    self.saveRecord()
                    setRankScore()
                    print(totalData)
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
    
    //列データを保存
    //    func saveMemberScoreData() {
    //        let realm = try! Realm()
    //
    //        //メンバー毎のスコアの保存処理
    //        let gameDataModel = GameDataModel()
    //        for row in memberScore {
    //            let memberScoreRow = List<ScoreDataModel>()
    //            for element in row {
    //                memberScoreRow.append(element)
    //            }
    //            gameDataModel.memberScoreData.append(objectsIn: memberScoreRow)
    //        }
    //
    //            try! realm.write {
    //                realm.add(gameDataModel)
    //            }
    //        }
    
    //メンバー毎の順位を作成
    func setRankScore() {
        var testData = [[Int]]()
        //スコアを順位に変換
        for row in rankData {
            let scores = row.map { $0.score }
            let sortedScores = scores.sorted(by: >)
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
        var memberRankData = [[Int]](repeating: [Int](repeating: 0, count: test2Data.count / 4), count: 4)
        
        for (index, score) in test2Data.enumerated() {
            let row = index % 4
            let column = index / 4
            memberRankData[row][column] = score
        }
        
        //メンバーのスコアを変換　仮
        var test3Data = [[Int]]()
        for row in scoreData {
            let scores = row.map { $0.score }
            test3Data.append(scores)
        }
        
        let testFilteredData = test3Data.filter { array in
            !array.allSatisfy { $0 == 0 }
        }
        
        var test4Data: [Int] = []
        for row in testFilteredData {
            for test in row {
                test4Data.append(test)
            }
        }
        var memberScoreData = [[Int]](repeating: [Int](repeating: 0, count: test4Data.count / 4), count: 4)
        
        for (index, score) in test4Data.enumerated() {
            let row = index % 4
            let column = index / 4
            memberScoreData[row][column] = score
        }
        
        print(memberRankData)
        print(memberScoreData)
        
    }
    
    // 対局の情報を保存する.
    func saveRecord() {
        //初期化
        let realm = try! Realm()
        var a:[ScoreDataModel]  = []
        
        for row in scoreData {
            for test in row {
                a.append(test)
            }
        }
        
        try! realm.write {
            let record = GameDataModel()
            record.date = Date()
            record.scoreData0.append(objectsIn: a)
            record.chipData.append(objectsIn: chipData)
            record.userNames.append(objectsIn: matchMember)
            //     record.memberScoreData.append(objectsIn: memberScore)
            realm.add(record)
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
             
        case .score:
            let rowIndex = index / 4
            let columnIndex = index % 4
            let addScoreData = ScoreDataModel()
            addScoreData.score = score
            scoreData[rowIndex][columnIndex] = addScoreData
            memberScore[columnIndex][rowIndex] = addScoreData
            rankData[rowIndex][columnIndex] = addScoreData
            print(memberScore[2][1])
        }
        
        // ゲームスコアの計算をする
        gameScoreCalculation(index: index)
        // collectionViewのreload
        collectionView3.reloadData()
        print(self.checkMemberData())
    }
    
    
    //行毎の数字を自動入力する実装
    func checkTest(index: Int) {
        let rowIndex = index / 4
        
        var scoreDataModel: [ScoreDataModel] = []
        
        let test = scoreData[rowIndex].map ({ $0.score ?? 0 })
        
        //空欄が1つだけか判定
        if let emptyIndex = test.firstIndex(of: 0), test.filter({ $0 != 0 }).count == test.count - 1 {
            let total = test.reduce(0, +)
            for (index, score) in test.enumerated() {
                let test2 = ScoreDataModel()
                test2.score = (index == emptyIndex) ? total : score
                scoreDataModel.append(test2)
                print(total)
                collectionView2.reloadData()
            }
        } else {
            for score in test {
                let test2 = ScoreDataModel()
                test2.score = score
                scoreDataModel.append(test2)
                print(score)
                collectionView2.reloadData()
            }
        }
        
        scoreData[rowIndex] = scoreDataModel
    }
    //
    //    func checkTest(rowIndex: Int) {
    //        var scoreDataModel: [ScoreDataModel] = []
    //        let test = scoreData[rowIndex].map {
    //            $0.score ?? 0
    //        }
    //
    //        for index in test.indices {
    //            let test2 = ScoreDataModel()
    //            test2.score = test[index]
    //            scoreDataModel.append(test2)
    //        }
    //        scoreData[rowIndex] = scoreDataModel
    //    }
    //
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
                    a += score.score
                    totalData[0] = a
                    
                case 1:
                    // B列の合計を計算する(左から2番目)
                    b += score.score
                    totalData[1] = b
                    
                case 2:
                    // C列の合計を計算する(左から3番目)
                    c += score.score
                    totalData[2] = c
                    
                case 3:
                    // D列の合計を計算する(左から4番目)
                    d += score.score
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
                a += chipData[0].chip
                totalData[0] = a
                
            case 1:
                // B列のチップを計算する(左から2番目)
                b += chipData[1].chip
                totalData[1] = b
                
            case 2:
                // C列のチップを計算する(左から3番目)
                c += chipData[2].chip
                totalData[2] = c
                
            case 3:
                // D列のチップを計算する(左から4番目)
                d += chipData[3].chip
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
                return matchMember.count * 10
                
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
 //           cell.editLabel()
            let username2 = matchMember[indexPath.row].memberName
            /// userneme2が空文字のときはサンプルメンバーを使う.
            cell.setText(username2.isEmpty ? sampleMember[indexPath.row] : username2 )
            //                let memberData = MemberDataModel()
            //                let a = MemberViewController()
            //                a.setUserData()
            //                let username2 = memberData.memberName
            //                cell.setText(username2)
            //                cell.setBackgroundColor(.lightGray)
            
            return cell
            
        } else if collectionView.tag == 2 {
            let cell = collectionView3.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! StartGameCollectionViewCell3
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
            
            if let gameScoreType = GameScoreType(rawValue: indexPath.section) {
                cell.setUp(index: indexPath.row, gameScoreType: gameScoreType)
            }
            return cell
        }
    }
    
    //    対局者を決定
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 && indexPath.section == 0 {
            let vc = SelectUserViewController()
            vc.index = indexPath
            vc.delegate = self
            //            print(indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }else {
        }
    }
    
    
    //    セクションのタイトルを設定
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        if collectionView.tag == 0 {
    //            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
    //            header.sectionLabel.text = collectionViewSection[indexPath.section]
    //
    //            return header
    //        }else if collectionView2.tag == 1 {
    //            let header = collectionView2.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
    //            header.sectionLabel.text = collectionViewSection2[indexPath.section]
    //            return header
    //        }else if collectionView2.tag == 2 {
    //            let header = collectionView3.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
    //            header.sectionLabel.text = collectionViewSection3[indexPath.section]
    //            return header
    //        }
    //        return UICollectionReusableView()
    //    }
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
    func selectUserViewController(user: UserDataModel, index: IndexPath) {
        if collectionView.tag == 0 {
            //            matchMember[index.row] = user.userName
            //            print(user.userName)
            //            print(matchMember)
            //            print(matchMember[1])
            let addMemberData = MemberDataModel()
            addMemberData.memberName = user.userName
            matchMember[index.row] = addMemberData
            
            collectionView.reloadData()
        }
    }
}
