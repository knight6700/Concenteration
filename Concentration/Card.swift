//
//  Card.swift
//  Concentration
//
//  Created by Mahmoud on 12/16/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
struct Card {
    
    // MARK: - Properties -
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    // MARK: - Initialization -
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //MARK: - Static methods and properties -
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
