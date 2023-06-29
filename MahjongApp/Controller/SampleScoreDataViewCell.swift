//
//  SampleScoreDataCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/06/22.
//

import Foundation
import UIKit
import RealmSwift

class SampleScoreDataViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    
    func setMember(_ text: String?) {
        label.text = text
    }
    
    func setScore(_ text: String?) {
        label.text = text
    }
    
    func setChip(_ text: String?) {
        label.text = text
    }
    
    func setborderColor() {
        let borderColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0).cgColor
        label.layer.borderColor = borderColor
       label.layer.borderWidth = 1
        
    }
    
}
