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
    
    let label = UILabel()
    
    override func prepareForReuse() {
            
        }
        
        func setText(_ text: String?) {
            matchName.text = text
            
        }
        
        func setBackgroundColor(_ color: UIColor) {
            contentView.backgroundColor = color
        }    
    }

