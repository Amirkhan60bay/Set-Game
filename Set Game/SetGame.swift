//
//  SetGameModel.swift
//  Set Game
//
//  Created by Amirkhan Alpysabayev on 7/16/20.
//  Copyright © 2020 Amirkhan Alpyspayev. All rights reserved.
//

import Foundation

struct SetGame{
    
    var (deck, gameCards) = generateCards()
    
    struct Card: Identifiable {
        
        var shape: Shape
        var shading: Shading
        var color: Color
        var number: Number
        var id: String
        
        var isChosen: Bool = false
        
        enum Shape: String, CaseIterable {
            case diamond, squiggle, oval
        }
        
        enum Shading: String, CaseIterable {
            case solid, striped, open
        }
        
        enum Color: String, CaseIterable {
            case red, green, blue
        }
        
        enum Number: Int, CaseIterable {
            case one = 1, two, three
        }
    }
    
    mutating func choose(card: Card) {
        print("card is chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.gameCards[chosenIndex].isChosen = !self.gameCards[chosenIndex].isChosen
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.gameCards.count {
            if self.gameCards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: Bogus!
    }
    
    static func generateCards() -> ([Card],[Card]) {
        var deck: [Card] = []
        var gameCards: [Card] = []
        
        for shape in Card.Shape.allCases{
            for shading in Card.Shading.allCases{
                for color in Card.Color.allCases{
                    for number in Card.Number.allCases{
                        deck.append(Card(shape: shape, shading: shading, color: color, number: number, id: String(number.rawValue)+color.rawValue+shading.rawValue+shape.rawValue))
                    }
                }
            }
        }
        
        deck.shuffle()
        
        for index in (0..<12){
            gameCards.append(deck[index])
            deck.removeFirst()
        }
        
        return (deck,gameCards)
    }
}
