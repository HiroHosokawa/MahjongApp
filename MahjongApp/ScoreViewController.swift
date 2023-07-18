//
//  ScoreViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/07/04.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    
    var index: Int?
    var member: UserMasterDataModel?
    var dataItem: [String] = ["2023年○月○日"]
    var score: [String] = ["合計","素点","チップ"]
    var rank: [String] = ["対局数","１着◯回　1位立◯％","2着◯回　2位立◯％","3着◯回　3位立◯％","4着◯回　4位立◯％"]
    var scoreSection: [String] = ["作成日","スコア","順位"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //           tableView.delegate = self
        tableView.dataSource = self
        setTableView()
        tableView.reloadData()
        self.title = "\(member?.userName ?? "")さんの成績"
        setData()
        //     navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    成績一覧を更新
    func setData() {
        score[0] = "合計: \(member?.userMasterScore?.total ?? 0)"
        score[1] = "素点: \(member?.userMasterScore?.score ?? 0)"
        score[2] = "チップ: \(member?.userMasterScore?.chip ?? 0)"
        
        let gameCount = Float(member?.userMasterScore?.matchCount ?? 0)
        let first = Float(member?.userMasterScore?.rank?.firstPlace ?? 0)
        let second = Float(member?.userMasterScore?.rank?.secondPlace ?? 0)
        let third = Float(member?.userMasterScore?.rank?.thirdPlace ?? 0)
        let forth = Float(member?.userMasterScore?.rank?.forthPlace ?? 0)
        rank[0] = "総対局数:  \(member?.userMasterScore?.matchCount ?? 0)局"
        rank[1] = "１着: \(member?.userMasterScore?.rank?.firstPlace ?? 0)回　1位率: \(first / gameCount * 100)％"
        rank[2] = "2着: \(member?.userMasterScore?.rank?.secondPlace ?? 0)回　2位率: \(second / gameCount * 100)％"
        rank[3] = "3着: \(member?.userMasterScore?.rank?.thirdPlace ?? 0)回　3位率: \(third / gameCount * 100)％"
        rank[4] = "4着: \(member?.userMasterScore?.rank?.forthPlace ?? 0)回　4位率: \(forth / gameCount * 100)％"
        //日付表示
        guard let a = member?.date else { return  }
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dataItem[0] = dateFormatter.string(from: a)
        
    }
    
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
}


extension ScoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return scoreSection.count
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return scoreSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(dataItem[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(score[indexPath.row])"
        }else if indexPath.section == 2 {
            cell.textLabel?.text = "\(rank[indexPath.row])"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataItem.count
        } else if section == 1 {
            return score.count
        } else if section == 2 {
            return rank.count
        } else {
            return 0
        }
    }
}

