//
//  Card.swift
//  ConcentrationGame
//
//  Created by ulzhan on 07.08.2022.
//

import Foundation

struct Card: Hashable{
    
    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
   private static var identifierNumber = 0
    
   private static func identifierGenerator() -> Int{
        identifierNumber += 1
        return identifierNumber
    }
    
    init(){
        self.identifier = Card.identifierGenerator()
    }
}
