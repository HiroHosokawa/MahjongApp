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
        self.title = "対局履歴"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setNavigationBarButton() {
        
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
