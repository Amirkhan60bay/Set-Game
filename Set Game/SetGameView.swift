//
//  ContentView.swift
//  Set Game
//
//  Created by Amirkhan Alpysabayev on 7/15/20.
//  Copyright © 2020 Amirkhan Alpyspayev. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel: ClassicSetGame
    
    var body: some View {

            Grid(viewModel.gameCards){ card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.purple)
    }
}

struct CardView: View {
    
    var card: SetGame.Card
     
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        
        // MARK: - Try to use Group{} to make it clearer code
        ZStack {
            if card.isChosen{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white).frame(width: size.width/2, height: size.height/2)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).frame(width: size.width/2, height: size.height/2)
                Text(card.id).frame(width: size.width/2, height: size.height/2)
            }
            else {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            Text(card.id)
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3

    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: ClassicSetGame())
    }
}
