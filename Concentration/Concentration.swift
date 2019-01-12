//
//  Concentration.swift
//  Concentration
//
//  Created by Mahmoud on 12/15/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
class Concentration {
    var cards = [Card]()
    
    var score = 0
    var flipCount = 0
    private var indexOfOneAndOnlyFaceUpCard: Int?
    private var previouslyFlippedCardIdentifiers = [Int]()
    
    // MARK: - Initialization -
    
    init(numberOfPairsOfCards: Int) {
        var initialDeck = [Card]()
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            initialDeck += [card, card]
        }
        while initialDeck.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(initialDeck.count)))
            let randomCard = initialDeck.remove(at: randomIndex)
            cards.append(randomCard)
        }
    }
    
    // MARK: - Public Methods -
    func chooseCard(at index: Int) {
        if false == cards[index].isMatched  {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                previouslyFlippedCardIdentifiers.append(matchIndex)
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else if previouslyFlippedCardIdentifiers.contains(cards[matchIndex].identifier) {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        flipCount += 1
    }
}

