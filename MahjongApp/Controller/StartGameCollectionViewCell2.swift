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
        contentView.backgroundColor = .blue
    }
    
    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}

