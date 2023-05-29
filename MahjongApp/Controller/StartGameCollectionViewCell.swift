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
        
        }
    
//    func setUpLabel(index: Int, gameScoreType: GameScoreType) {
//        
//    }
    
    func setborderColor() {
    let borderColor = UIColor(red: 255/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0).cgColor
    matchName.layer.borderColor = borderColor
    }
        
        func setText(_ text: String?) {
            matchName.text = text
            
        }
        
        func setBackgroundColor(_ color: UIColor) {
            contentView.backgroundColor = color
        
        }    
    }

