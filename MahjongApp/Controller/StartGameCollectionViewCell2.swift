//
//  StartGameCollectionViewCell2.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/03/07.
//

import UIKit

class StartGameCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var inputScore: UITextField!
    
    let textField = UITextField()
    
    override func prepareForReuse() {
        textFieldLayout()
        
    }
    
    
    
    func textFieldLayout() {
        textField.layer.cornerRadius = 0
        textField.attributedPlaceholder = NSAttributedString(string: "placeholder text",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
}

