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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "GameDataTableViewCell", bundle: nil), forCellReuseIdentifier: "GameDataTableViewCell")
        setNavigationBarButton()
        self.title = "履歴"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataTableViewCell")as! GameDataTableViewCell
        
        
        
        
        cell.gameMember1.text = gameDataList[indexPath.row].userNames[0].memberName
        cell.gameMember2.text = gameDataList[indexPath.row].userNames[1].memberName
        cell.gameMember3.text = gameDataList[indexPath.row].userNames[2].memberName
        cell.gameMember4.text = gameDataList[indexPath.row].userNames[3].memberName
        cell.gameCount.text = "\(gameDataList[indexPath.row].gamecount)局"
        print(gameDataList[indexPath.row].gamecount)
        
        cell.total1.text = "\(gameDataList[indexPath.row].totalScoreData[0].score ?? 0)"
        cell.total2.text = "\(gameDataList[indexPath.row].totalScoreData[1].score ?? 0)"
        cell.total3.text = "\(gameDataList[indexPath.row].totalScoreData[2].score ?? 0)"
        cell.total4.text = "\(gameDataList[indexPath.row].totalScoreData[3].score ?? 0)"
        
        cell.chip1.text = "\(gameDataList[indexPath.row].chipData[0].chip ?? 0)"
        cell.chip2.text = "\(gameDataList[indexPath.row].chipData[1].chip ?? 0)"
        cell.chip3.text = "\(gameDataList[indexPath.row].chipData[2].chip ?? 0)"
        cell.chip4.text = "\(gameDataList[indexPath.row].chipData[3].chip ?? 0)"
        let a = gameDataList[indexPath.row].date
       
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy年MM月dd日"

        let date = dateFormatter.string(from: a)
        cell.gameData.text = "\(date)"
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
    

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let vc = StartGameViewController()
            vc.test = true
            vc.index = indexPath
            
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(vc, animated: true)

    }
}
