//
//  SystemViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/13.
//

import Foundation
import UIKit

class SystemViewController: UIViewController {
    
    let informationitem: NSArray = ["バージョン　〇〇"]
    let dataItem: NSArray = ["初期化","データダウンロード"]
    let inquiryItem: NSArray = ["メールでの問い合わせ"]
    let systemSection: NSArray = ["情報","データ","問い合わせ"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        setTableView()
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

extension SystemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Mycell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(informationitem[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(dataItem[indexPath.row])"
        }else if indexPath.section == 2 {
            cell.textLabel?.text = "\(inquiryItem[indexPath.row])"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return informationitem.count
        } else if section == 1 {
            return dataItem.count
        } else if section == 2 {
            return inquiryItem.count
        } else {
            return 0
        }
    }
}
