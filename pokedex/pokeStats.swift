//
//  pokeStats.swift
//  pokedex
//
//  Created by Aluno Mack on 15/04/25.
//

import Foundation

struct TypeStat: Identifiable {
    var type: ElementType
    var amount: Int
    var representation: Double
    
    var id: ElementType { type }
}

func getTypeStats(allPokemons: [Pokemon], capturedPokemons: [Pokemon]) -> [TypeStat] {
    var totalByType: [ElementType: Int] = [:]
    for pokemon in allPokemons {
        for type in pokemon.types {
            totalByType[type, default: 0] += 1
        }
    }
    
    var capturedByType: [ElementType: Int] = [:]
    for pokemon in capturedPokemons {
        for type in pokemon.types {
            capturedByType[type, default: 0] += 1
        }
    }
    
    return ElementType.allCases.map { type in
        let total = totalByType[type] ?? 0
        let captured = capturedByType[type] ?? 0
        let percentage = total > 0 ? (Double(captured) / Double(total) * 100) : 0.0
        return TypeStat(type: type, amount: captured, representation: percentage)
    }
}

