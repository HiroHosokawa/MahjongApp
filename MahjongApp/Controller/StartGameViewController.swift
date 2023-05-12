
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.


import Foundation
import UIKit

class StartGameViewController: UIViewController {
    var matchMember: [String] = ["あなた", "A", "B", "C", "D", ]
    var matchMember2: [String] = ["あなた", "A", "B", "C", "D", ]
    var collectionViewSection: [String] = ["対局メンバー","合計"]
    var collectionViewSection2: [String] = ["チップ入力欄","スコア入力欄"]
    let scoreData = ScoreData()
    var scoreList: [Any] = []
    let matchData = MatchData()
    
    let startGameCollectionViewCell2 = StartGameCollectionViewCell2()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        self.title = "日付入力"
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
    
    init() {
        super.init(nibName: String(describing: StartGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setNavigationBarButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "リセット", style: .plain, target: self, action: #selector(didTapResetButton))
    }
    
    @objc func didTupDone() {
        view.endEditing(true)
    }
    var toolBar: UIToolbar {
        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        let toolBar = UIToolbar(frame: toolBarRect)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTupDone))
        toolBar.setItems([doneItem], animated: true)
        return toolBar
    }
    
    @objc func didTapSaveButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "対局の終了",
            message: "対局を保存して終了します。よろしいですか？",
            preferredStyle: .alert)
        
        let add = UIAlertAction(
            title: "保存",
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

extension StartGameViewController: UICollectionViewDelegate {
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
                
            case 2:
                return 50
                
            default:
                print("error")
                return 0
            }
        }
    }
    // メンバーとスコアのコレクションビューをswich文で表示
    //        let cellType = Cell(rawValue: indexPath.row)!
    //                       switch cellType {
    //                       case .startGameCollectionViewCell:
    //                                   return 5
    //                       case .startGameCollectionViewCell2:
    //                           return 20
    //                       }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            switch(indexPath.section){
            case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
            let username2 = matchMember[indexPath.row]
            //色々いじる
            cell.setText(username2)
            cell.setBackgroundColor(.lightGray)
            return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
                let sumScore: String = "合計値"
                cell.setText(sumScore)
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }else  {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! StartGameCollectionViewCell2
//            scoreData.score = startGameCollectionViewCell2.inputScore.text ?? ""
//            matchData.scoreList.insert(scoreData.score, at: indexPath.row)
            print(scoreData.score)
            cell.inputScore.inputAccessoryView = toolBar
//            let scorekari = matchMember2[indexPath.row]
//            cell.scoreLabel(scorekari)
            
            print(scoreList)
            scoreList = [indexPath]
            return cell
            
        }
    }
    // メンバーとスコアのコレクションビューをswich文で表示
    //        let cellType = Cell(rawValue: indexPath.row)!
    //
    //                switch cellType {
    //
    //                case .startGameCollectionViewCell:
    //                            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
    //                            let username = matchMember[indexPath.row]
    //                            //色々いじる
    //                            cell.setText(username)
    //                            cell.setBackgroundColor(.lightGray)
    //                            return cell
    //                case .startGameCollectionViewCell2:
    //                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! StartGameCollectionViewCell2
    //                    return cell
    //                }
    //    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let vc = SelectUserViewController()
            vc.index = indexPath
            vc.delegate = self
            print(indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }else {
//            let vc = StartGameCollectionViewCell2()
//            vc.index = indexPath
//            vc.delegate = self
        }
    }
    
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



//     func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
//        {
//
//            if (kind == "UICollectionElementKindSectionHeader") {
//                        //ヘッダーの場合
//                let testSection = collectionView2.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! TestCollectionReusableView
//
//
//                //ヘッダーの背景色は紫、ラベルにセクション名を設定する。
//                testSection.backgroundColor = UIColor(red: 0.7, green: 0.7,blue: 0.8, alpha: 1.0)
//                testSection.sectionLabel.text = collectionViewSection[indexPath.section]
//
//                return testSection
//
//
//            }
//        }


extension StartGameViewController: UICollectionViewDelegateFlowLayout {
    
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
        // minimumLineSpacingForSectionAtとminimumInteritemSpacingForSectionAt、collectionviewのレイアウトをひとまとめにしたが、セクション毎のアイテム数が設定できず没
        //    func numberOfItemsInRow(_ number: CGFloat) {
        //
        //        if collectionView.tag == 0 {
        //            let layout = UICollectionViewFlowLayout()
        //            let width: CGFloat = UIScreen.main.bounds.width / 5
        //            let height: CGFloat = UIScreen.main.bounds.height / 20
        //            layout.itemSize = CGSize(width: width, height: height)
        //            layout.minimumLineSpacing = 0
        //            layout.minimumInteritemSpacing = 0
        //
        //            collectionView.collectionViewLayout = layout
        //        }else if collectionView.tag == 1 {
        //            let layout = UICollectionViewFlowLayout()
        //            let width: CGFloat = UIScreen.main.bounds.width / 5
        //            let height: CGFloat = width
        //            layout.itemSize = CGSize(width: width, height: height)
        //            layout.minimumLineSpacing = 0
        //            layout.minimumInteritemSpacing = 0
        //        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: self.view.bounds.width, height: 30)
    }
}

extension StartGameViewController: SelectUserViewControllerDelegate  {
    func selectUserViewController(user: UserData, index: IndexPath) {
        if collectionView.tag == 0 {
            matchMember[index.row] = user.userName
            print(user.userName)
            collectionView.reloadData()
        }
    }
}
//extension StartGameViewController: StartGamerViewControllerCell2Delegate  {
//    func startGamerViewControllerCell2(StartGameCollectionViewCell2: UITextField, index: IndexPath) {
//        if collectionView.tag == 1 {
//            matchMember2[index.row] = startGameCollectionViewCell2.inputScore
//            collectionView.reloadData()
//        }
//    }
//}
