//
//  ViewController.swift
//  Concentration
//
//  Created by Mahmoud on 12/8/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   lazy  var game = Concentration(numberOfPairsOfCards: CardButtons.count-1/2)
    var flipCount = 0 { didSet{ flipCountLabel.text = "flips: \(flipCount )"} }
    var score = 0 { didSet { scoreLabel.text = "Score: \(score)" } }
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var CardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        
        
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen Card Was not in CardButtons")
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func startNewGameAction(_ sender: Any) {
        startNewGame()
    }
    
    func updateViewFromModel()  {
        for index in CardButtons.indices {
            let button = CardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        score = game.score
    }
    let emojiLibrary = [
        0:["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
        1:["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"],
        2:["🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒"],
        3:["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓"],
        4:["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒"],
        5:["🍼","☕️","🍵","🥤","🍶","🍺","🥂","🍷","🥃"]
    ]
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    private func setRandomTheme() {
        let theme = Int(arc4random_uniform(UInt32(emojiLibrary.keys.count)))
        if let chosenEmojiSet = emojiLibrary[theme] {
            emojiChoices = chosenEmojiSet
        }
        else {
            print("Failed to choose emoji set, because key theme #\(theme) does not exist in emoji library")
        }
    }
    
     func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    private func startNewGame() {
        game = Concentration(numberOfPairsOfCards: (CardButtons.count + 1) / 2)
        setRandomTheme()
        updateViewFromModel()
        flipCount = 0
    }
}


