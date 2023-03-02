//
//  CollectionViewCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/24.
//

import UIKit
import Foundation

class StartGameCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    @IBOutlet weak var matchName: UILabel!
    
    override func prepareForReuse() {
//        contentView.backgroundColor = .lightGray
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .systemGray6
        
//        contentView.addSubview(label)
//        label.frame = .init(x: 0, y: 0, width: 60, height: 30)
//        label.textColor = .black
//        label.text = "初期値"
//        label.backgroundColor = .red
    }
    
    func setText(_ text: String?) {
        matchName.text = text
        label.text = text
    }
    
    func setBackgroundColor(_ color: UIColor) {
//        contentView.backgroundColor = color
    }
}

