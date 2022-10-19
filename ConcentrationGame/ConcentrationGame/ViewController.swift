//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by darkhan on 07.08.2022.
//

import UIKit

class ViewController: UIViewController {

   private lazy var game = ConcentrationGame1(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributedString
    }
    
    private(set) var touches = 0 {
        didSet {
            updateTouches()
        }
    }
    
 
  // private var emojiCollection = ["🦊", "🐥", "🦊", "🐝", "🦋", "🐥", "🐸", "🦄","🐼", "🐬", "🐯", "🐶", "🐙", "🐰", "🐢", "🐗"]
    
    private var emojiCollection = "🦊🐥🦊🐝🦋🐥🐸🦄🐼🐬🐯🐶🐙🐰🐢🐗"
    
   private var emojiDictionary = [Card:String]()
    
    
   private func emojiIdentifier(for card: Card) -> String{
        if emojiDictionary[card] == nil{
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtention)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
   private func updateViewFromModel() {
        for index in buttonCollection.indices{
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.white : UIColor.blue
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet{
            updateTouches()
        }
    }
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.choosecard(at: buttonIndex)
            updateViewFromModel()
    }
}
    
    
}

extension Int {
    var arc4randomExtention: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
