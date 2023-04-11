//
//  StartGameCollectionViewCell2.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/03/07.
//

import UIKit

protocol StartGamerViewControllerCell2Delegate: AnyObject {
    func startGamerViewControllerCell2(StartGameCollectionViewCell2: UITextField, index: IndexPath)
}

class StartGameCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var inputScore: UITextField!
    
    weak var delegate: StartGamerViewControllerCell2Delegate?
        var index: IndexPath?
    
    
    
    
    override func prepareForReuse() {
     //textFieldLayout()
        inputScore.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputScore.delegate = self
    }
    
    @objc func textFieldDidChange(_ inputScore: UITextField) {
        if let text = inputScore.text {
            print("aaa")
            print(text)
        }
    }
    
    func scoreLabel(_ text: String) {
        inputScore.text =  text
    }
    
//    func textFieldLayout() {
//        inputScore.layer.cornerRadius = 0
//        inputScore.attributedPlaceholder = NSAttributedString(string: "placeholder text",
//                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//    }
}

extension StartGameCollectionViewCell2: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (inputScore.text as NSString?)?.replacingCharacters(in: range, with: string)
        print(text ?? "")
        return true
    }
}
