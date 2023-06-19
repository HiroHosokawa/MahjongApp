//
//  StartGameCollectionViewCell2.swift
//  MahjongApp
//
//  Created by 細川比呂 on 2023/03/07.
//

import UIKit

// デリゲート.
protocol StartGamerViewControllerCell2Delegate: AnyObject {
    func setGameScore(score: Int, index: Int, gameScoreType: GameScoreType)
}

class StartGameCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var inputScore: UITextField!
    
    weak var delegate: StartGamerViewControllerCell2Delegate?
    var index: Int = 0
    var gameScoreType: GameScoreType = .chip
    
    override func awakeFromNib() {
            super.awakeFromNib()
    }
    /// cellの初期化処理.
    func setUp(index: Int, gameScoreType: GameScoreType) {
        inputScore.delegate = self
        self.index = index
        self.gameScoreType = gameScoreType
    }
    
    //リセットボタン押下時にスコアを白紙にする
    func deletScore() {
     
    }
 
// スコアの＋ーに合わせて色を変更する
//    func setTextColor(textField: UITextField) {
//        let text = textField.text
//        
//        
//    }
    
    func scoreLabel(_ text: String) {
        inputScore.text =  text
    }
}

extension StartGameCollectionViewCell2: UITextFieldDelegate {
    /// textField入力制御のメソッド
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        var allowedCharacters = CharacterSet.decimalDigits
        allowedCharacters.insert("-")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    /// 入力が完了したら呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 編集終了の処理を実行する
        if let text = textField.text, let score = Int(text) {
            delegate?.setGameScore(
                score: score,
                index: index,
                gameScoreType: gameScoreType
            )
//            print("ok")
//            print(score)
//            print(index)
//            print(type(of: score))
        }
        //数値によって色の変更を実行する
        if let text = textField.text, let number = Int(text) {
            textField.textColor = number < 0 ? .red : number > 0 ? .blue : .black
        }
    }
}
