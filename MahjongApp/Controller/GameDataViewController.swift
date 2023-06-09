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
        
        cell.gameMember1.text = gameDataList[indexPath.row].userNames[0].memberName
        cell.gameMember2.text = gameDataList[indexPath.row].userNames[1].memberName
        cell.gameMember3.text = gameDataList[indexPath.row].userNames[2].memberName
        cell.gameMember4.text = gameDataList[indexPath.row].userNames[3].memberName
        cell.gameCount.text = "\(gameDataList.count)局"
        let a = gameDataList[indexPath.row].date
       
        let date = Calendar.current.startOfDay(for: a)
        cell.gameData.text = "\(date)"
        print(date)
        return cell
    }
}

extension GameDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.gameDataList[indexPath.row])
                }
                gameDataList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }catch{
            }
        }
    }
}
