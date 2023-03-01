
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.


import Foundation
import UIKit


class StartGameViewController: UIViewController {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        self.title = "日付入力"
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "StartGameCollectionViewCell", bundle: nil)
                collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
        
        
            
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
    
}

extension StartGameViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    

    
}

extension StartGameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //CustumCellを宣言する
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StartGameCollectionViewCell
                //色々いじる
                cell.setText("Hello")
                cell.setBackgroundColor(.lightGray)
                
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //遷移内容を記載？
        }
}

extension StartGameViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width / 5.572
        let height: CGFloat = UIScreen.main.bounds.height / 20
        return CGSize(width: width, height: height)
    }
    
    
    
}
