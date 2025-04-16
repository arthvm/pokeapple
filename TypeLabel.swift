//
//  TypeLabel.swift
//  pokedex
//
//  Created by Ian Rossato Braga on 16/04/25.
//

import SwiftUI

struct TypeLabel: View {
    var type: ElementType = .normal
    
    var body: some View {
        Text(type.rawValue.capitalized)
            .foregroundStyle(.white)
            .fontWeight(.medium)
            .padding([.horizontal], 14)
            .padding([.vertical], 6)
            .background(.white.opacity(0.25))
            .cornerRadius(20)
    }
}

#Preview {
    TypeLabel(type: .grass)
}
