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

class Pokedex: ObservableObject {
    @Published var allPokemons: [Pokemon] = pokemonsData
    @Published var myPokedex: [Pokemon] = []
    @Published var capturedCount = 0
    @Published var currentStats: [TypeStat] = []

    func wasCaptured(pokemon: Pokemon) -> Bool {
        return self.myPokedex.contains(where: { $0.id == pokemon.id })
    }

    func toggleCaptured(pokemon: Pokemon) {
        if wasCaptured(pokemon: pokemon) {
            self.myPokedex.removeAll { $0.id == pokemon.id }
        } else {
            self.myPokedex.append(pokemon)
        }

        capturedCount = self.myPokedex.count
        self.updateStats()  // Atualiza as estatísticas apenas quando há mudança no Pokedex
    }

    func updateStats() {
        var totalByType: [ElementType: Int] = [:]
        for pokemon in self.allPokemons {
            for type in pokemon.types {
                totalByType[type, default: 0] += 1
            }
        }

        var capturedByType: [ElementType: Int] = [:]
        for pokemon in self.myPokedex {
            for type in pokemon.types {
                capturedByType[type, default: 0] += 1
            }
        }

        self.currentStats = ElementType.allCases.map { type in
            let total = totalByType[type] ?? 0
            let captured = capturedByType[type] ?? 0
            let percentage = total > 0 ? (Double(captured) / Double(total) * 100) : 0.0
            return TypeStat(type: type, amount: captured, representation: percentage)
        }
    }
}
