//
//  CollectionViewCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/24.
//

import UIKit
import Foundation

class StartGameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var machName: UILabel!
    
    override func prepareForReuse() {
            contentView.backgroundColor = .lightGray
        }
        
        func setText(_ text: String?) {
            machName.text = text
        }
        
        func setBackgroundColor(_ color: UIColor) {
            contentView.backgroundColor = color
        }
    }

