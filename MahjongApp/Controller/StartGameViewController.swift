
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
    //対局者のデータ
    var matchMember = [MemberDataModel](repeating: .init(), count: 5)
    var collectionViewSection: [String] = ["対局メンバー","合計"]
    var collectionViewSection2: [String] = ["チップ入力欄","スコア入力欄"]
    /// 合計値のデータ.
    private var totalData = [Int](repeating: 0, count: 5)
    /// チップのデータ.
    private var chipData = [ChipDataModel](repeating: .init(), count: 5)
    /// スコアのデータ.
    private var scoreData = [ScoreDataModel](repeating: .init(), count: 50)
    
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
    
    // Realmデータに保存されているかチェックする(後で削除する).
    // 一番左のスコア入力欄の数字をPrint出力する.
    func checkTestSavedScoreData() {
        let realm = try! Realm()
        var data: [GameDataModel] = []
        let result = realm.objects(GameDataModel.self)
        
        data = Array(result)
        
        if !data.isEmpty {
            print(data[0].score[0].score, "テストです")
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
        let nib = UINib(nibName: "StartGameCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
        let nib2 = UINib(nibName: "StartGameCollectionViewCell2", bundle: nil)
        collectionView2!.register(nib2, forCellWithReuseIdentifier: "Cell2")
        let nib3 = UINib(nibName: "TestCollectionReusableView", bundle: nil)
        collectionView!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView2!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
    
    // ダイアログの保存Button処理.
    @objc func didTapSaveButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "対局の終了",
            message: "対局を保存して終了します。よろしいですか？",
            preferredStyle: .alert)
        
        let add = UIAlertAction(
            title: "保存",
            style: .default,
            handler: { (action) -> Void in
                self.saveRecord()
                
                print("OK")
            })
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alert.addAction(add);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
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
                print("OK")
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
        //初期化
        let realm = try! Realm()
        try! realm.write {
            let record = GameDataModel()
            record.date = Date()
            record.score.append(objectsIn: scoreData)
            record.chipData.append(objectsIn: chipData)
            record.userNames.append(objectsIn: matchMember)
            realm.add(record)
            print(record)
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
            
            print(chipData[0])
        case .score:
            let addScoreData = ScoreDataModel()
            addScoreData.score = score
            scoreData[index] = addScoreData
        }
        
        // ゲームスコアの計算をする
        gameScoreCalculation()
        // collectionViewのreload
        collectionView.reloadData()
    }
    
    /// ゲームスコアの計算をする
    private func gameScoreCalculation() {
        /// Aさん.
        var a = 0
        /// Bさん.
        var b = 0
        /// Cさん.
        var c = 0
        /// Dさん.
        var d = 0
        /// Eさん.
        var e = 0
        
        //0
        // TODO: ここのロジックはリファクタリングできる(優先度: 中)
        for(index,score) in scoreData.enumerated() {
            switch index % 5 {
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
                
            case 4:
                // E列の合計を計算する(左から5番目)
                e += score.score
                totalData[4] = e
                
            default:
                break
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
                
            case 4:
                // E列のチップを計算する(左から5番目)
                e += chipData[4].chip
                totalData[4] = e
                
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
        }else if collectionView2.tag == 1 {
            return collectionViewSection2.count
        }else {
            return 2
        }
    }
}

extension StartGameViewController: UICollectionViewDataSource {
    //    セクション毎にセルの個数を設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            switch(section){
            case 0:
                return 5
            case 1:
                return 5
            default:
                print("error")
                return 0
            }
        }else  {
            switch(section){
            case 0:
                return 5
                
            case 1:
                return 50
                
                
            default:
                print("error")
                return 0
            }
        }
    }
    
    //    カスタムセルの内容を表示する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
            
            switch(indexPath.section){
            case 0:
                let memberData = MemberDataModel()
                let username2 = memberData.memberName
                cell.setText(username2)
               // cell.setBackgroundColor(.lightGray)
                return cell
            case 1:
                cell.setText(String(totalData[indexPath.row]))
        
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }else  {
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
            print(indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }else {
        }
    }
    //    セクションのタイトルを設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
            header.sectionLabel.text = collectionViewSection[indexPath.section]
            return header
        }else if collectionView2.tag == 1 {
            let header = collectionView2.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
            header.sectionLabel.text = collectionViewSection2[indexPath.section]
            return header
        }
        return UICollectionReusableView()
    }
}


extension StartGameViewController: UICollectionViewDelegateFlowLayout {
    //    セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let width: CGFloat = UIScreen.main.bounds.width / 5
            let height: CGFloat = UIScreen.main.bounds.height / 20
            return CGSize(width: width, height: height)
        }else  {
            let width: CGFloat = UIScreen.main.bounds.width / 5
            let height: CGFloat = UIScreen.main.bounds.height / 20
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
