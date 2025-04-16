//
//  PokeAPI.swift
//  pokedex
//
//  Created by Aluno Mack on 16/04/25.
//

import Foundation

struct PokemonSprites: Codable {
    var front_default: String
    var back_default: String
}

struct PokemonData: Codable {
    var sprites: PokemonSprites
}

struct PokemonWithData {
    var pokemon: Pokemon
    var data: PokemonData
}

class PokeAPI {
    func getPokemonData(pokemon: Pokemon) async throws -> PokemonWithData {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)/") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
        
        return PokemonWithData(pokemon: pokemon, data: pokemonData)
    }
}
