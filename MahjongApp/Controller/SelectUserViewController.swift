//
//  SelectUserViewController.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/03/01.
//

import Foundation
import UIKit
import RealmSwift

protocol SelectUserViewControllerDelegate: AnyObject {
    func selectUserViewController(user: UserMasterDataModel, index: IndexPath)
}

class SelectUserViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SelectUserViewControllerDelegate?
    var index: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButton()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserData()
        tableView.reloadData()
    }
    
    func setNavigationBarButton() {
        let navigationBar = UINavigationBar()
        self.title = "メンバーを選択してください"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(didTapAddButton))
        self.view.addSubview(navigationBar)
    }
    
    func setUserData() {
        let realm = try! Realm()
        let result = realm.objects(UserMasterDataModel.self)
        userDataList = Array(result)
        tableView.reloadData()
    }
    
    var userDataList: [UserMasterDataModel] = []
    
    
    
    // 重複チェック
    func checkName(_ userName: String) -> Bool {
        let realm = try! Realm()
        let existingUser = realm.objects(UserMasterDataModel.self).filter("userName == %@", userName).first
        return existingUser != nil
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "面子の追加", message: "名前を入力してください。", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "5文字以内"
            textField.delegate = self
        })
        let add = UIAlertAction(
            title: "追加",
            style: .default,
            handler: { [self] (action) -> Void in
                if let textFieldInAlert = alert.textFields?.first {
                    let newUserName = textFieldInAlert.text ?? ""
                    if checkName(newUserName) {
                        // 重複している場合はアラートを表示
                        let duplicateAlert = UIAlertController(title: "同じ名前は追加できません。", message: "", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        duplicateAlert.addAction(okAction)
                        self.present(duplicateAlert, animated: true, completion: nil)
                    } else {
                        // 重複がない場合はデータを追加
                        let userData = UserMasterDataModel()
                        userData.userName = newUserName
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.add(userData)
                            }
                            setUserData()
                        } catch {
                            print("error")
                        }
                    }
                }
            })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        alert.addAction(add)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SelectUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let user = userDataList[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = user.userName
        cell.contentConfiguration = config
        return cell
    }
    
}

extension SelectUserViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        let user = userDataList[indexPath.row]
        delegate?.selectUserViewController(user: user, index: index!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.userDataList[indexPath.row])
                }
                userDataList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }catch{
            }
        }
    }
}

extension SelectUserViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 現在のテキストフィールドのテキスト
        let currentText = textField.text ?? ""
        // 入力されたテキスト
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        // 文字数の制限
        let characterLimit = 5
        return newText.count <= characterLimit
    }
}
