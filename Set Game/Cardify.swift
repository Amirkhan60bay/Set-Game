//
//  Cardify.swift
//  Set Game
//
//  Created by Amirkhan Alpysabayev on 7/22/20.
//  Copyright © 2020 Amirkhan Alpyspayev. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var number: Int
    
    func body(content: Content) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            VStack{
                ForEach(0..<number) { shape in
                    content
                }
            }
            .padding()
        }
    }
    
    // MARK: - Drawing constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
}
