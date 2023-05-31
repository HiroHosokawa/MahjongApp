//
//  GameDataViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/13.
//

import UIKit
import Foundation
import RealmSwift

class GameDataViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var gameDataList: [GameDataModel]  = []
    var memberDataList: [MemberDataModel] = []
    var scoreDataList: [ScoreDataModel] = []
    var chipDataList: [ChipDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "GameDataTableViewCell", bundle: nil), forCellReuseIdentifier: "GameDataTableViewCell")
        setNavigationBarButton()
        self.title = "対局履歴"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
        setGameData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setNavigationBarButton() {
    }
    
    func setGameData() {
        let realm = try! Realm()
//        let result = realm.objects(MemberDataModel.self)
//        memberDataList = Array(result)
        let result2 = realm.objects(GameDataModel.self)
        gameDataList = Array(result2)
        
    }
    
}

extension GameDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDataList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataTableViewCell")as! GameDataTableViewCell
        
        cell.gameMember1.text = memberDataList[indexPath.row].memberName
        cell.gameMember2.text = memberDataList[indexPath.row].memberName
        cell.gameMember3.text = memberDataList[indexPath.row].memberName
        cell.gameMember4.text = memberDataList[indexPath.row].memberName
        cell.gameCount.text = "13局"
       // cell.gameData = gameDataList[indexPath.row].date
        
        return cell
    }
}
