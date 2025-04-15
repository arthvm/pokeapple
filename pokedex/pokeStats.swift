//
//  pokeStats.swift
//  pokedex
//
//  Created by Aluno Mack on 15/04/25.
//

import Foundation

struct TypeStat {
    var type: ElementType
    var amount: Int
    var representation: Double
}

func getTypeStats(pokemons: [Pokemon]) -> [TypeStat] {
    var typeCount: [ElementType: Int] = [:]
    
    for pokemon in pokemons {
        for type in pokemon.types {
            typeCount[type, default: 0] += 1
        }
    }
    
    return typeCount.map { (type, count) in
        let percentage = Double(count) / Double(pokemons.count) * 100
        
        return TypeStat(type: type, amount: count, representation: percentage)
    }
}
