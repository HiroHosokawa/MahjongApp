
//
//  CollectionViewCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/24.
//

import UIKit
import Foundation

class StartGameCollectionViewCell3: UICollectionViewCell {
    
    
    @IBOutlet weak var totalName: UILabel!
    
    override func prepareForReuse() {
        setborderColor2()
        
    }
    
    
//    func editLabel2() {
//        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: 15, height: 15);_
//    }
    
    func deletText() {
        totalName.text = ""
        //ラベルの高さ処理
        totalName.translatesAutoresizingMaskIntoConstraints = false
            totalName.numberOfLines = 0
            totalName.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setborderColor2() {
        let borderColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0).cgColor
        totalName.layer.borderColor = borderColor
        totalName.layer.borderWidth = 1
        
    }
    
    
    func setText2(_ text: String?) {
        totalName.text = text
    }
    
    func setTextColor() {
        if let number = Int(totalName.text ?? "") {
            totalName.textColor = number < 0 ? .red : number > 0 ? .blue : .black
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}

