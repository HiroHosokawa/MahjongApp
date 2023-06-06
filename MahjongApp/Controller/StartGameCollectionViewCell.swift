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
    
    override func prepareForReuse() {
        setborderColor()
        
        }
    
//    func setUpLabel(index: Int, gameScoreType: GameScoreType) {
//        
//    }
    
    
    func setborderColor() {
        let borderColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0).cgColor
    matchName.layer.borderColor = borderColor
        matchName.layer.borderWidth = 1
   
    }
        
        func setText(_ text: String?) {
            matchName.text = text
            
            
        }
    func setTextColor() {
        matchName.textColor = UIColor.red
    }
        
        func setBackgroundColor(_ color: UIColor) {
            contentView.backgroundColor = color
        
        }    
    }

