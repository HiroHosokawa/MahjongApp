//
//  GameDataViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/13.
//

import UIKit
import Foundation

class GameDataViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "GameDataTableViewCell", bundle: nil), forCellReuseIdentifier: "GameDataTableViewCell")
        setNavigationBarButton()
    }
    
    func setNavigationBarButton() {
        let navigationBar = UINavigationBar()
        navigationBar.frame = CGRect(x: 0, y: 50, width: 375, height: 0)
        let navigationItem : UINavigationItem = UINavigationItem(title: "対局一覧")
        navigationBar.pushItem(navigationItem, animated: true)
        self.view.addSubview(navigationBar)
    }
}

extension GameDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataTableViewCell")as! GameDataTableViewCell
        return cell
    }
}
