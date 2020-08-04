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
        
        VStack{
            Grid(viewModel.gameCards){ card in
                CardView(card: card)
                    .onAppear().transition(.offset(x: CGFloat(Int.random(in: 1000...2000) * ((Int.random(in: -1...1)) > 0 ? 1 : -1)), y: CGFloat(Int.random(in: 1000...2000) * ((Int.random(in: -1...1))>0 ? 1 : -1))))
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)){
                            self.viewModel.choose(card: card)
                        }
                }
                    .padding(7)
                }
            .padding()
            .foregroundColor(Color.purple)
            
            HStack{
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)){
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game")
                    .padding(.horizontal, 55)
                    .padding(.vertical, 15)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule()) })
                    .animation(.easeInOut(duration: 0.35))
                
                Button(action: {
                    self.viewModel.Change3Cards()
                }, label: { Text("Add Cards")
                    .padding(.horizontal, 55)
                    .padding(.vertical, 15)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule()) })
            }
        }
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
        shape()
        .modifier(Cardify(number: card.number.rawValue))
        .frame(width: card.isChosen ? size.width/scaleFactor : size.width, height: card.isChosen ? size.height/scaleFactor : size.height)
    }

    // MARK: - Drawing constants
    let lineWidth: CGFloat = 7
    let shapeOpacity = 0.5
    let scaleFactor: CGFloat = 1.5
    
    func shape() -> some View {
        
        switch card.shape {
        case .diamond:
            switch card.shading {
            case .open:
                switch card.color{
                case.blue:
                    return AnyView(Diamond().stroke(Color.blue, lineWidth: lineWidth))
                case.green:
                    return AnyView(Diamond().stroke(Color.green, lineWidth: lineWidth))
                case .red:
                    return AnyView(Diamond().stroke(Color.red, lineWidth: lineWidth))
                }
            case .solid:
                switch card.color{
                case.blue:
                    return AnyView(Diamond().fill(Color.blue))
                case.green:
                    return AnyView(Diamond().fill(Color.green))
                case .red:
                    return AnyView(Diamond().fill(Color.red))
                }
            case .striped:
                switch card.color{
                case.blue:
                    return AnyView(Diamond().fill(Color.blue).opacity(shapeOpacity))
                case.green:
                    return AnyView(Diamond().fill(Color.green).opacity(shapeOpacity))
                case .red:
                    return AnyView(Diamond().fill(Color.red).opacity(shapeOpacity))
                }
            }
        case .oval:
            switch card.shading {
            case .open:
                switch card.color{
                case.blue:
                    return AnyView(Capsule().stroke(Color.blue, lineWidth: lineWidth))
                case.green:
                    return AnyView(Capsule().stroke(Color.green, lineWidth: lineWidth))
                case .red:
                    return AnyView(Capsule().stroke(Color.red, lineWidth: lineWidth))
                }
            case .solid:
                switch card.color{
                case.blue:
                    return AnyView(Capsule().fill(Color.blue))
                case.green:
                    return AnyView(Capsule().fill(Color.green))
                case .red:
                    return AnyView(Capsule().fill(Color.red))
                }
            case .striped:
                switch card.color{
                case.blue:
                    return AnyView(Capsule().fill(Color.blue).opacity(shapeOpacity))
                case.green:
                    return AnyView(Capsule().fill(Color.green).opacity(shapeOpacity))
                case .red:
                    return AnyView(Capsule().fill(Color.red).opacity(shapeOpacity))
                }
            }
        case .squiggle:
            switch card.shading {
            case .open:
                switch card.color{
                case.blue:
                    return AnyView(Rectangle().stroke(Color.blue, lineWidth: lineWidth))
                case.green:
                    return AnyView(Rectangle().stroke(Color.green, lineWidth: lineWidth))
                case .red:
                    return AnyView(Rectangle().stroke(Color.red, lineWidth: lineWidth))
                }
            case .solid:
                switch card.color{
                case.blue:
                    return AnyView(Rectangle().fill(Color.blue))
                case.green:
                    return AnyView(Rectangle().fill(Color.green))
                case .red:
                    return AnyView(Rectangle().fill(Color.red))
                }
            case .striped:
                switch card.color{
                case.blue:
                    return AnyView(Rectangle().fill(Color.blue).opacity(shapeOpacity))
                case.green:
                    return AnyView(Rectangle().fill(Color.green).opacity(shapeOpacity))
                case .red:
                    return AnyView(Rectangle().fill(Color.red).opacity(shapeOpacity))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: ClassicSetGame())
    }
}
