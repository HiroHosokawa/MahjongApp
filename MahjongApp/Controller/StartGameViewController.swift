
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.


import Foundation
import UIKit


class StartGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        
        self.title = "スタート画面"
    }
    
    init() {
        super.init(nibName: String(describing: StartGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "リセット", style: .plain, target: self, action:nil)
        
        // TODO: 背景色をつける
    }
    
    @objc private func didTapSaveButton(_ sender: UIBarButtonItem) {
        // アラート表示
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        
        self.present(vc, animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        // アラートのOKアクションの中でRealmに保存する処理を書く
        
    }
    
}
