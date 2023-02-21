//
//  GameDataTableViewCell.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/02/15.
//

import UIKit

class GameDataTableViewCell: UITableViewCell {

    @IBOutlet weak var gameData: UILabel!
    @IBOutlet weak var gameCount: UILabel!
    @IBOutlet weak var gameMember1: UILabel!
    @IBOutlet weak var gameMember2: UILabel!
    @IBOutlet weak var gameMember3: UILabel!
    @IBOutlet weak var gameMember4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
