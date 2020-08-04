//
//  ClassicSetGame.swift
//  Set Game
//
//  Created by Amirkhan Alpysabayev on 7/17/20.
//  Copyright © 2020 Amirkhan Alpyspayev. All rights reserved.
//

import SwiftUI

class ClassicSetGame: ObservableObject {
    @Published private var model = SetGame()
    
    var isSet: Bool = false
    
    // MARK: - Access to the Model
    var deck: Array<SetGame.Card> {
        model.deck
    }
    
    var gameCards: Array<SetGame.Card> {
        model.gameCards
    }
    
    var chosenCards: [SetGame.Card] {
        model.chosenCards
    }
    
    // MARK: - Intents
    func choose(card: SetGame.Card) {
        model.choose(card: card)
//        isSet = model.isSet
    }
    
    func Change3Cards(){
        model.Change3Cards()
    }
    
    func resetGame(){
        model = SetGame()
    }
}
