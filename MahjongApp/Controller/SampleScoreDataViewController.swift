////
////  SampleScoreData.swift
////  MahjongApp
////
////  Created by 細川比呂 on 2023/06/22.
////
//
//import Foundation
//import UIKit
//import RealmSwift
//import SwiftUI
//
//class SampleScoreDataViewController: UIViewController {
//
//
//    @IBOutlet weak var collectionView: UICollectionView!
//
//
//    //対局者のデータ
//    var sampleMember: [String] = ["未入力","未入力","未入力","未入力"]
//    var matchMember = [MemberDataModel](repeating: .init(), count: 4)
//    var collectionViewSection: [String] = ["対局メンバー","合計","チップ入力欄","スコア入力欄"]
//
//    /// 合計値のデータ.
//    var totalData = [Int](repeating: 0, count: 4)
//    /// チップのデータ.
//    private var chipData = [ChipDataModel](repeating: .init(), count: 4)
//    /// スコアのデータ.
//    var scoreData = [ScoreDataModel](repeating: .init(), count: 40)
//    //対局者毎のスコア
//    private var memberScore = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 10), count: 4)
//    //対局者の順位づけに必要なデータ
//    private var rankData = [[ScoreDataModel]](repeating: [ScoreDataModel](repeating: .init(), count: 4), count: 10)
//
//
//    let startGameCollectionViewCell = SampleScoreDataViewCell()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // CollectionViewをセットする
//        setCollectionViews()
//        self.title = "対局"
//
//    }
//
//
//
//
//
////    init() {
////        super.init(nibName: String(describing: SampleScoreDataViewController.self), bundle: nil)
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
//
//
////    func setData(){
////        let realm = try! Realm()
////        var data: [GameDataModel] = []
////        let result = realm.objects(GameDataModel.self)
////
////        data = Array(result)
////
////        if !data.isEmpty {
////            print(data[0].scoreData0[0].score!, "テストです")
////        }
////    }
//    //    colectionViewをセット
//    func setCollectionViews() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        let nib = UINib(nibName: "StartGameCollectionViewCell", bundle: nil)
//        collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
//
//        let nib3 = UINib(nibName: "SampleSectionHeaderReusableView", bundle: nil)
//        collectionView!.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//
//    }
//}
//
//extension SampleScoreDataViewController: UICollectionViewDelegate {
//    //    colectionView毎のセクション数を設定
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//
//            return 4
//
//        }
//}
//
//extension SampleScoreDataViewController: UICollectionViewDataSource {
//
//
//    //    セクション毎にセルの個数を設定
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch(section){
//        case 0:
//            return 5
//
//        case 1:
//            return 5
//        case 2:
//            return 5
//        case 3:
//            return 40
//
//        default:
//            print("error")
//            return 0
//    }
//    }
//
//    //    カスタムセルの内容を表示する
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SampleScoreDataViewCell
//            cell.setborderColor()
//            //           cell.editLabel()
//        switch indexPath.section {
//        case 0:
//            let username2 = matchMember[indexPath.row].memberName
//            cell.setMember(username2.isEmpty ? sampleMember[indexPath.row] : username2)
//
//            return cell
//        case 1:
//            let username2 = matchMember[indexPath.row].memberName
//            cell.setMember(username2.isEmpty ? sampleMember[indexPath.row] : username2)
//            return cell
//        case 2:
//            let chip = chipData[indexPath.row].chip
//            cell.setChip(String(chip))
//            return cell
//        case 3:
//            let score1 = scoreData[indexPath.row].score
//            let stringScore = Int(score1 ?? 0)
//            cell.setScore(String(stringScore))
//            return cell
//        default:
//            break
//
//        }
//        return cell
//    }
//
//
//    //    セクションのタイトルを設定
//        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! TestCollectionReusableView
//                header.sectionLabel.text = collectionViewSection[indexPath.section]
//
//                return header
//
//}
//}
//
//
//extension SampleScoreDataViewController: UICollectionViewDelegateFlowLayout {
//    //    セルのサイズを設定
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width: CGFloat = UIScreen.main.bounds.width / CGFloat(matchMember.count)
//        let height: CGFloat = UIScreen.main.bounds.height / 15
//        return CGSize(width: width, height: height)
//
//    }
//    //    セル列の余白の間隔調整
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return 0
//    }
//    //セル行間の余白を調整
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return 0
//    }
//    //セクション名とサイズを設定
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: self.view.bounds.width, height: 30)
//    }
//}
//
//
