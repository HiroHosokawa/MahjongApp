
//InputScoreViewController.swift
//MahjongApp

// Created by 細川比呂 on 2023/02/12.


import Foundation
import UIKit


class StartGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
    }
    
    init() {
        super.init(nibName: String(describing: StartGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigationBarButton() {
        let navigationBar = UINavigationBar()
        navigationBar.frame = CGRect(x: 0, y: 50, width: 375, height: 0)
        let navigationItem : UINavigationItem = UINavigationItem(title: "日付入力")
        navigationBar.pushItem(navigationItem, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action:nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "リセット", style: .plain, target: self, action:nil)
        self.view.addSubview(navigationBar)
    }
    
}
