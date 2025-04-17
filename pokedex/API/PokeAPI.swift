import Foundation

struct PokemonSprites: Codable {
    var front_default: String
    var back_default: String
}

struct FormDescriptions: Codable {
    var description: String
}

struct PokemonData: Codable {
    var sprites: PokemonSprites
}

struct PokemonSpeciesData: Codable {
    var form_descriptions: [FormDescriptions]
}

struct PokemonWithData {
    var pokemon: Pokemon
    var data: PokemonData
    var species: PokemonSpeciesData
}

class PokeAPI {
    func getPokemonData(pokemon: Pokemon) async throws -> PokemonWithData {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)/") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.id)/") else { throw URLError(.badURL) }
        
        let (speciesData, _) = try await URLSession.shared.data(from: url)
        let pokemonSpeciesData = try JSONDecoder().decode(PokemonSpeciesData.self, from: speciesData)
        
        return PokemonWithData(pokemon: pokemon, data: pokemonData, species: pokemonSpeciesData)
    }
}
