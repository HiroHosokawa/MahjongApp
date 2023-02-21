//
//  MemberViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/13.
//

import Foundation
import UIKit
import RealmSwift

var addButtonItem: UIBarButtonItem!

class MemberViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        tableView.dataSource = self
        addUser()
        
    }
    
    func setNavigationBarButton() {
        let navigationBar = UINavigationBar()
        
        navigationBar.frame = CGRect(x: 0, y: 50, width: 375, height: 0)
        let navigationItem : UINavigationItem = UINavigationItem(title: "面子一覧")
        navigationBar.pushItem(navigationItem, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: nil)
        self.view.addSubview(navigationBar)
    }
    
    func setUserData() {
        let realm = try! Realm()
        let result = realm.objects(UserData.self)
        userDataList = Array(result)
    }
    
    var userDataList: [UserData] = []
    
    func addUser() {
        let alert = UIAlertController(title: "面子の追加", message: "名前を入力してください。", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "４文字以内"
            
        })
        
        let add = UIAlertAction(
            title: "追加",
            style: .default,
            handler: { (action) -> Void in
            print("OK")
                
                alert.textFields?.first
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        alert.addAction(add);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
    }
}

extension MemberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //            let userData: UserData = userDataList[indexPath.row]
        //            cell.userName.text = userData.text
        return cell
    }
}
