//
//  CollectionViewCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/24.
//

import UIKit
import Foundation

class StartGameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var matchName: UILabel!
    
    @IBOutlet weak var totalName: UILabel!
    override func prepareForReuse() {
        setborderColor()
        
    }
    
    
//    func editLabel() {
//        let label = UILabel()
//        let startGameViewController = StartGameViewController()
//        let rabelHight = matchName.layer.bounds.width / 15
//
//        let rabelWidth = matchName.layer.bounds.width / CGFloat(startGameViewController.matchMember.count)
//    }
    
    func setborderColor() {
        let borderColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0).cgColor
        matchName.layer.borderColor = borderColor
        matchName.layer.borderWidth = 1
        
    }
    
    
    
    
    
    func setText(_ text: String?) {
        matchName.text = text
        //ラベルの高さ処理
        matchName.translatesAutoresizingMaskIntoConstraints = false
            matchName.numberOfLines = 0
            matchName.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setTextColor() {
        if let number = Int(matchName.text ?? "") {
            totalName.textColor = number < 0 ? .red : number > 0 ? .blue : .black
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}

