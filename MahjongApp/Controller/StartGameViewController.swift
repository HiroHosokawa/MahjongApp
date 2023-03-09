
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.


import Foundation
import UIKit


class StartGameViewController: UIViewController {
    var matchMember: [String] = ["あなた", "A", "B", "C", "D", ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
        enum Cell: Int, CaseIterable {
            case startGameCollectionViewCell
            case startGameCollectionViewCell2


            var cellIdentifier: String {
                switch self {
                case .startGameCollectionViewCell: return "StartGameCollectionViewCell"
                case .startGameCollectionViewCell2: return "StartGameCollectionViewCell2"
                }
            }
    }
   // let cellType = Cell(rawValue: indexPath.row)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        self.title = "日付入力"
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "StartGameCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
        
        let nib2 = UINib(nibName: "StartGameCollectionViewCell2", bundle: nil)
        collectionView!.register(nib2, forCellWithReuseIdentifier: "Cell2")
        numberOfItemsInRow(5)
        
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
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    //
    //            return 0.0
    //      }
    
}

extension StartGameViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension StartGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
        let cellType = Cell(rawValue: indexPath.row)!
                       switch cellType {
                       case .startGameCollectionViewCell:
                                   return 5
                       case .startGameCollectionViewCell2:
                           return 20
                       }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = Cell(rawValue: indexPath.row)!
        
                switch cellType {

                case .startGameCollectionViewCell:
                            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
                            let username = matchMember[indexPath.row]
                            //色々いじる
                            cell.setText(username)
                            cell.setBackgroundColor(.lightGray)
                            return cell
                case .startGameCollectionViewCell2:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! StartGameCollectionViewCell2
                    return cell
                }
    }
        //CustumCellを宣言する
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
//        let username = matchMember[indexPath.row]
//        //色々いじる
//        cell.setText(username)
//        cell.setBackgroundColor(.lightGray)
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectUserViewController()
        vc.index = indexPath
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartGameViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width: CGFloat = UIScreen.main.bounds.width / 5
//        let height: CGFloat = UIScreen.main.bounds.height / 20
//        return CGSize(width: width, height: height)
//    }
     func numberOfItemsInRow(_ number: CGFloat) {

            let layout = UICollectionViewFlowLayout()
            let width: CGFloat = UIScreen.main.bounds.width / 5
            let height: CGFloat = UIScreen.main.bounds.height / 20
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0

            collectionView.collectionViewLayout = layout
        }
    
//     func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//     ) -> CGFloat {
//         return 1
//     }
//
//     func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAt section: Int
//     ) -> CGFloat {
//    return 0
//     }
}

extension StartGameViewController: SelectUserViewControllerDelegate  {
    func selectUserViewController(user: UserData, index: IndexPath) {
        matchMember[index.row] = user.userName
        collectionView.reloadData()
    }
}
