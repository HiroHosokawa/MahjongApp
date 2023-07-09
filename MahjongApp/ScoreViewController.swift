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
    let dataItem: [String] = ["2023年○月○日"]
    let score: [String] = ["合計","素点","チップ"]
    let rank: [String] = ["対局数","１着◯回　1位立◯％","2着◯回　2位立◯％","3着◯回　3位立◯％","4着◯回　4位立◯％"]
    
    let scoreSection: [String] = ["作成日","スコア","順位"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //           tableView.delegate = self
        tableView.dataSource = self
        setTableView()
        tableView.reloadData()
        self.title = "\(member?.userName ?? "")の成績"
        
        //     navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTableView() {
        //        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        //        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //        let displayWidth: CGFloat = self.view.frame.width
        //        let displayHeight: CGFloat = self.view.frame.height
        //    tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
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

