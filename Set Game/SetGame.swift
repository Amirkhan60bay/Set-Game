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
    var chosenCards: [Card] = []
//    var isSet: Bool = false
    
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
    
    mutating func Change3Cards() {
        for i in 0..<gameCards.count {
            self.gameCards[i].isChosen = false
        }
        chosenCards.removeAll()
        
        for index in 0..<3 {
            if !deck.isEmpty{
                let tempCard = self.gameCards[index]
                self.gameCards[index] = deck.last!
                deck.removeLast()
                deck.append(tempCard)
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card is chosen: \(card.number) \(card.shading) \(card.color) \(card.shape)")
        if let chosenIndex = gameCards.firstIndex(matching: card){
            self.gameCards[chosenIndex].isChosen = !self.gameCards[chosenIndex].isChosen
            
            if self.gameCards[chosenIndex].isChosen {
                chosenCards.append(gameCards[chosenIndex])
            } else{
                chosenCards = chosenCards.filter { $0.id != self.gameCards[chosenIndex].id}
            }
            if chosenCards.count == 3{
                
                if isSet(){
                    var SetCardsIndices: [Int] = []
//                    isSet = true
                    print("SET! \n")
                    
                    
                    for i in 0..<gameCards.count {
                        if (self.gameCards[i].id == chosenCards[0].id) || (self.gameCards[i].id == chosenCards[1].id) || (self.gameCards[i].id == chosenCards[2].id) {
                            SetCardsIndices.append(i)
                        }
                    }
                    
                    for index in SetCardsIndices {
                        if !deck.isEmpty{
                            self.gameCards[index] = deck.last!
                            deck.removeLast()
                            SetCardsIndices.removeFirst()
                        }
                    }

                    
                } else{
                    print("NOT SET! \n")
                    for i in 0..<gameCards.count {
                        self.gameCards[i].isChosen = false
                    }
                }
                    chosenCards.removeAll()
            }
        }
    }
    
    func isSet() -> Bool {
        return (sameShape() || differentShape()) && (sameShading() || differentShading()) && (sameColor() || differentColor()) && (sameNumber() || differentNumber())
    }
    
    func sameShape() -> Bool {
        return (chosenCards[0].shape == chosenCards[1].shape && chosenCards[0].shape == chosenCards[2].shape)
    }
    
    func differentShape() -> Bool{
        return (chosenCards[0].shape != chosenCards[1].shape && chosenCards[0].shape != chosenCards[2].shape && chosenCards[1].shape != chosenCards[2].shape)
    }
    
    func sameShading() -> Bool {
        return (chosenCards[0].shading == chosenCards[1].shading && chosenCards[0].shading == chosenCards[2].shading)
    }
    
    func differentShading() -> Bool{
        return (chosenCards[0].shading != chosenCards[1].shading && chosenCards[0].shading != chosenCards[2].shading && chosenCards[1].shading != chosenCards[2].shading)
    }
    
    func sameColor() -> Bool {
        return (chosenCards[0].color == chosenCards[1].color && chosenCards[0].color == chosenCards[2].color)
    }
    
    func differentColor() -> Bool{
        return (chosenCards[0].color != chosenCards[1].color && chosenCards[0].color != chosenCards[2].color && chosenCards[1].color != chosenCards[2].color)
    }
    
    func sameNumber() -> Bool {
        return (chosenCards[0].number == chosenCards[1].number && chosenCards[0].number == chosenCards[2].number)
    }
    
    func differentNumber() -> Bool{
        return (chosenCards[0].number != chosenCards[1].number && chosenCards[0].number != chosenCards[2].number && chosenCards[1].number != chosenCards[2].number)
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
